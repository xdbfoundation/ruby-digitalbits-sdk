module Digitalbits
  class TransactionBuilder
    attr_reader :source_account, :sequence_number, :base_fee, :time_bounds, :memo, :operations

    class << self
      # This enable user to call shortcut methods, like
      # TransactionBuilder.payment(...),
      # TransactionBuilder.manage_data(...) and etc.
      # It reduces the boilerplate, when you just need to
      # shoot a single operation in transaction
      def method_missing(method_name, *args, **kwargs)
        unless Digitalbits::Operation.respond_to?(method_name)
          return super
        end

        op = Digitalbits::Operation.send(method_name, **kwargs)

        new(**kwargs).add_operation(op).build
      end

      def respond_to_missing?(method_name, include_private = false)
        Digitalbits::Operation.respond_to?(method_name) || super
      end
    end

    def initialize(
      source_account:,
      sequence_number:,
      base_fee: 100,
      time_bounds: nil,
      memo: nil,
      **_ # ignore any additional parameters without errors
    )
      raise ArgumentError, "Bad :source_account" unless source_account.is_a?(Digitalbits::KeyPair)
      raise ArgumentError, "Bad :sequence_number" unless sequence_number.is_a?(Integer) && sequence_number >= 0
      raise ArgumentError, "Bad :time_bounds" unless time_bounds.is_a?(Digitalbits::TimeBounds) || time_bounds.nil?
      raise ArgumentError, "Bad :base_fee" unless base_fee.is_a?(Integer) && base_fee >= 100

      @source_account = source_account
      @sequence_number = sequence_number
      @base_fee = base_fee
      @time_bounds = time_bounds

      if time_bounds.nil?
        set_timeout(0)
      end

      @memo = make_memo(memo)
      @operations = []
    end

    def build
      if @time_bounds.nil?
        raise "TransactionBuilder.time_bounds must be set during initialization or by calling set_timeout"
      elsif !@time_bounds.min_time.is_a?(Integer) || !@time_bounds.max_time.is_a?(Integer)
        raise "TimeBounds.min_time and max_time must be Integers"
      elsif @time_bounds.max_time != 0 && @time_bounds.min_time > @time_bounds.max_time
        raise "Timebounds.max_time must be greater than min_time"
      end

      attrs = {
        source_account: @source_account.muxed_account,
        fee: @base_fee * @operations.length,
        seq_num: @sequence_number,
        time_bounds: @time_bounds,
        memo: @memo,
        operations: @operations,
        ext: Digitalbits::Transaction::Ext.new(0)
      }

      @sequence_number += 1

      Digitalbits::Transaction.new(attrs)
    end

    def build_fee_bump(inner_txe:)
      if inner_txe.switch == Digitalbits::EnvelopeType.envelope_type_tx_v0
        inner_txe = Digitalbits::TransactionEnvelope.v1(tx: inner_txe.tx.to_v1, signatures: inner_txe.signatures)
      elsif inner_txe.switch != Digitalbits::EnvelopeType.envelope_type_tx
        raise ArgumentError, "Invalid inner transaction type #{inner_txe.switch}"
      end

      inner_tx = inner_txe.tx
      inner_ops = inner_tx.operations
      inner_base_fee_rate = inner_tx.fee.fdiv(inner_ops.length)

      # The fee rate for fee bump is at least the fee rate of the inner transaction
      if @base_fee < inner_base_fee_rate
        raise "Insufficient base_fee, it should be at least #{inner_base_fee_rate} stroops."
      end

      Digitalbits::FeeBumpTransaction.new(
        fee_source: @source_account.muxed_account,
        fee: @base_fee * (inner_ops.length + 1),
        inner_tx: Digitalbits::FeeBumpTransaction::InnerTx.new(:envelope_type_tx, inner_txe.v1!),
        ext: Digitalbits::FeeBumpTransaction::Ext.new(0)
      )
    end

    def add_operation(operation)
      raise ArgumentError, "Bad operation" unless operation.is_a? Digitalbits::Operation
      @operations.push(operation)
      self
    end

    def clear_operations
      @operations.clear
      self
    end

    def set_source_account(account_kp)
      raise ArgumentError, "Bad source account" unless account_kp.is_a?(Digitalbits::KeyPair)
      @source_account = account_kp
      self
    end

    def set_sequence_number(seq_num)
      raise ArgumentError, "Bad sequence number" unless seq_num.is_a?(Integer) && seq_num >= 0
      @sequence_number = seq_num
      self
    end

    def set_timeout(timeout)
      if !timeout.is_a?(Integer) || timeout < 0
        raise ArgumentError, "Timeout must be a non-negative integer"
      end

      if @time_bounds.nil?
        @time_bounds = Digitalbits::TimeBounds.new(min_time: 0, max_time: nil)
      end

      @time_bounds.max_time = timeout == 0 ? timeout : Time.now.to_i + timeout

      self
    end

    def set_memo(memo)
      @memo = make_memo(memo)
      self
    end

    def set_base_fee(base_fee)
      raise ArgumentError, "Bad base fee" unless base_fee.is_a?(Integer) && base_fee >= 100
      @base_fee = base_fee
      self
    end

    def make_memo(memo)
      case memo
      when Digitalbits::Memo
        memo
      when nil
        Memo.new(:memo_none)
      when Integer
        Memo.new(:memo_id, memo)
      when String
        Memo.new(:memo_text, memo)
      when Array
        t, val = *memo
        Memo.new(:"memo_#{t}", val)
      else
        raise ArgumentError, "Bad :memo"
      end
    end
  end
end
