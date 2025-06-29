package junit.basic;

import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;

public class BankAccountTest {

    private BankAccount account;

    @Before
    public void setUp() {
        System.out.println("Setting up account with ₹1000");
        account = new BankAccount(1000);  
    }

    @After
    public void tearDown() {
        System.out.println("Resetting account...\n");
        account = null;
    }

    @Test
    public void testDeposit() {      
        account.deposit(500);       
        assertEquals("Balance should be ₹1500 after deposit", 1500, account.getBalance(), 0.01);
    }

    @Test
    public void testWithdraw() {     
        account.withdraw(300);
        assertEquals("Balance should be ₹700 after withdrawal", 700, account.getBalance(), 0.01);
    }

    @Test
    public void testWithdrawMoreThanBalance() {        
        account.withdraw(2000);
        assertEquals("Withdrawal above balance should be ignored", 1000, account.getBalance(), 0.01);
    }
}
