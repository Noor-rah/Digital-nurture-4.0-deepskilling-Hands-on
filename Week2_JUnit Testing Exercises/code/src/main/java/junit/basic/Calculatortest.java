package junit.basic;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class Calculatortest {
	@Test
    public void testAdd() {
        Calculator calc = new Calculator();
        int result = calc.add(2, 3);
        assertEquals(5, result);
    }
	@Test
    public void testSub() {
        Calculator calc = new Calculator();
        int result = calc.sub(12, 9);
        assertEquals(3, result);
    }
	@Test
    public void testMul() {
        Calculator calc = new Calculator();
        int result = calc.mul(5, 2);
        assertEquals(10, result);
    }
	@Test
    public void testDiv() {
        Calculator calc = new Calculator();
        int result = calc.div(4, 1);
        assertEquals(4, result);
    }
}
