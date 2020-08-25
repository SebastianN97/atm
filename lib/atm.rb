require 'date'
class Atm
    attr_accessor :funds

    def initialize
        @funds = 1000
    end

    def withdraw(amount, account)
        case
        when insufficient_funds_in_account?(amount, account)
            { status: false, message: 'insufficient funds in account', date: Date.today}
        when insufficient_funds_in_atm?(amount)
            { status: false, message: 'insufficient funds in ATM', date: Date.today}
        when card_expired?(account.exp_date)
            { status: false, message: 'card expired', date: Date.today }
        else
            perform_transaction(amount, account)
        end
    end

    private

    def insufficient_funds_in_account?(amount, account)
        amount > account.balance
    end

    def perform_transaction(amount, account)
        @funds -= amount
        account.balance = account.balance - amount
        { status: true, message: 'success', date: Date.today, amount: amount }
    end

    def insufficient_funds_in_atm?(amount)
        @funds < amount
    end

    def card_expired?(exp_date)
        Date.strptime(exp_date, '%m/%y') < Date.today
    end
end 

 


