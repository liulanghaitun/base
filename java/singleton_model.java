 严格来说，这并不算一个模式，只是利用Java自身的特性(私有化构造函数).
如果构造函数私有化，则如下所示:
private Singleton()
{
 
}
因为构造函数私有化，所以只有在类中可以创建对象。为了获取类中创建的对象，

第一类：通过公共静态字段获取
我们可以用final进行修饰(final并不是必须的),只是更加明显的标志不变性.
package com.test;

public class Singleton
{
 public static final Singleton INSTANCE = new Singleton();
 
 private Singleton()
 {
  
 }
 
 public static void main(String[] args)
 {
  for (int index = 0; index < 5; index++)
  {
   new Thread(new Runnable()
   {  
    @Override
    public void run()
    {
     System.out.println(Singleton.INSTANCE);
    }
   }).start();
  }
 }
}
测试结果:
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806

第二类:通过公共的静态方法来实现.
public class Singleton
{
 private Singleton()
 {
  
 }
 
 public static Singleton getInstance()
 {
  return null;
 }
}

对于对象的创建位置不同，可以分为两种,静态方法内部和外部.

第一种:静态方法内部
静态方法只能访问静态变量，所以我们可以创建静态全局变量,为了保持单一性,必须对instance进行判断.
如果instance为空则创建，否则直接返回该对象，保证对象的唯一性.
package com.test;

public class Singleton
{
 private static Singleton instance = null;
 
 private Singleton()
 {
  
 }
 
 public static Singleton getInstance()
 {
  if (null == instance)
  {
   instance = new Singleton();
  }
  return instance;
 }
 
 public static void main(String[] args)
 {
  for (int index = 0; index < 5; index++)
  {
   new Thread(new Runnable()
   {   
    @Override
    public void run()
    {
     System.out.println(Singleton.getInstance());
    }
   }).start();
  }
 }
 
}

测试结果：
com.test.Singleton@69ed56e2
com.test.Singleton@69ed56e2
com.test.Singleton@6cce82cc
com.test.Singleton@69ed56e2
com.test.Singleton@69ed56e2
从上述数据中看出,多线程的时候，必须进行数据同步.
package com.test;

public class Singleton
{
 private static Singleton instance = null;
 
 private Singleton()
 {
  
 }
 
 public static synchronized Singleton getInstance()
 {
  if (null == instance)
  {
   instance = new Singleton();
  }
  return instance;
 }
 
 public static void main(String[] args)
 {
  for (int index = 0; index < 5; index++)
  {
   new Thread(new Runnable()
   {  
    @Override
    public void run()
    {
     System.out.println(Singleton.getInstance());
    }
   }).start();
  }
 }
 
}
测试结果:
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806
com.test.Singleton@1ba4806


第二种:静态方法的外部
我们可以用final进行修饰(final并不是必须的),只是更加明显的标志不变性.
package com.test;

public class Singleton
{
 private static final Singleton INSTANCE = new Singleton();
 
 private Singleton()
 {
  
 }
 
 public static Singleton getInstance()
 {
  return INSTANCE;
 }
 
 public static void main(String[] args)
 {
  for (int index = 0; index < 5; index++)
  {
   new Thread(new Runnable()
   {   
    @Override
    public void run()
    {
     System.out.println(Singleton.getInstance());
    }
   }).start();
  }
 }
}
测试结果是:
com.test.Singleton@62b92956
com.test.Singleton@62b92956
com.test.Singleton@62b92956
com.test.Singleton@62b92956
com.test.Singleton@62b92956

第一种方式需要的时候才创建,但是多线程的时候需要进行同步.
第二种方式在类加载的时就创建,多线程的时候不需要同步  
