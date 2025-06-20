class SingletonPatternExample
{
    public static void main(String str[])
    {
        Logger l1=Logger.getInstance();
        Logger l2=Logger.getInstance();
        System.out.println(l1);
        System.out.println(l2);
    }
}
class Logger
{
    private static Logger instance = new Logger();
    private Logger()
    {
        
    }
    public static Logger getInstance()
    {
        return instance;
    }
}