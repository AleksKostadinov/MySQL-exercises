# Find Full Name
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name ()
BEGIN
	SELECT CONCAT_WS(" ", first_name, last_name) AS full_name FROM account_holders
    ORDER BY full_name, id;
END $$


# People with Balance Higher Than
DELIMITER $$

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(money DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name FROM account_holders AS ah
    LEFT JOIN accounts AS a ON ah.id = a.account_holder_id
	GROUP BY first_name, last_name
    HAVING SUM(a.balance) > money;
END $$

# Future Value Function
DELIMITER $$

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_rate DOUBLE, years INT)
RETURNS DECIMAL(19, 4)
DETERMINISTIC
BEGIN
	DECLARE future_sum DECIMAL(19, 4);
    SET future_sum := sum * POW(1 + yearly_rate, years);
    RETURN future_sum;
END $$

# Calculating Interest
DELIMITER $$

CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, rate DECIMAL(19, 4))
BEGIN
	SELECT 
    a.id, 
    ah.first_name, 
    ah.last_name, 
    a.balance,
	ufn_calculate_future_value(a.balance, rate, 5) AS "balance_in_5_years"
    FROM account_holders AS ah
    JOIN accounts AS a ON a.account_holder_id = ah.id
    WHERE id = a.id;
END $$

# Deposit Money
DELIMITER $$

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
	BEGIN
		START TRANSACTION;
			IF (money_amount <= 0) THEN 
				ROLLBACK;
            ELSE
				UPDATE accounts 
				SET balance = balance + money_amount
				WHERE id = account_id;
				COMMIT;
            END IF;
    END $$

# Withdraw Money
DELIMITER $$

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
	BEGIN
		START TRANSACTION;
			IF (money_amount <= 0 OR 
            (SELECT balance FROM `accounts` WHERE `id` = account_id) < money_amount) 
            THEN ROLLBACK;
            ELSE
				UPDATE accounts 
				SET balance = balance - money_amount
				WHERE id = account_id;
            END IF;
    END $$


# Money Transfer
DELIMITER $$

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION;
		IF
			from_account_id = to_account_id OR
            amount <= 0 OR
            (SELECT balance FROM accounts WHERE id = from_account_id) < amount OR
            (SELECT COUNT(id) FROM accounts WHERE id = from_account_id) <> 1 OR
            (SELECT COUNT(id) FROM accounts WHERE id = to_account_id) <> 1
            THEN ROLLBACK;
		ELSE    
			UPDATE accounts SET balance = balance - amount
			WHERE id = from_account_id;
			UPDATE accounts SET balance = balance + amount
			WHERE id = to_account_id;
			COMMIT;
		END IF;
        
END $$

# Log Accounts Trigger
CREATE TABLE `logs`(
	`log_id` INT PRIMARY KEY AUTO_INCREMENT, 
	`account_id` INT NOT NULL,
	`old_sum` DECIMAL(19, 4) NOT NULL,
	`new_sum` DECIMAL(19, 4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER tr_change_balance
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum) 
	VALUES (OLD.id, OLD.balance, NEW.balance);
END $$


# Emails Trigger
CREATE TABLE `notification_emails`(
	`id` INT PRIMARY KEY AUTO_INCREMENT, 
	`recipient` INT NOT NULL,
	`subject` TEXT,
	`body` TEXT
);

DELIMITER $$
CREATE TRIGGER tr_email_on_change_balance
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
	VALUES (NEW.`account_id`, 
    concat_ws(' ', 'Balance change for account:', NEW.`account_id`), 
    concat_ws(' ', 'On', NOW(), 'your balance was changed from', NEW.`old_sum`, 'to', NEW.`new_sum`, '.'));
END $$

