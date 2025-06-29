package junit.basic;
import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        assertEquals("Addition is  30", 30, 20 + 10);
   
        assertTrue("8 is bigger than 2", 8 > 2);

         assertFalse("5 is Smaller than 3", 5 < 3);
     
        String str = null;
        assertNull("String is in null type", str);

        Object obj = new Object();
        assertNotNull("Object must not be in null type", obj);
    }
}
