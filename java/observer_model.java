

观察者模式：定义对象之间的一对多关系，当一变化的时候，所有依赖一的对象会收到消息.

软件开发中唯一不变的是变化，变化的部分多是扩展部分。通过抽象的手段可以消弭掉变化的部分。
面向对象有个里氏替换原则，该原则具有将多个子类映射到同一个父类的能力，通过里氏替换原则和
组合原则就可以实现基本的扩展功能.

对于观察者模式而言，有一个可观察者(Observable)和多个观察者(Observer),当Observable的数据变化的时候
多个Observer会收到消息，Observer依赖于Observable的数据.
相同的消息对于不同的Observer会产生不同的影响.因此通过定义一个抽象接口来消弭变化.

定义观察者:
public interface Observer
{
 void update(Object data);
}
其中data就是变化的数据，观察者可以通过该参数收到变化的数据,并且根据该数据处理相应的逻辑.
 
定义可观察者:
public class Observable
{
 // 收集观察者
 private List<Observer> observers;
 
 public Observable()
 {
  observers = new ArrayList<Observer>();
 }
 
 // 添加观察者
 public void addObserver(Observer observer)
 {
  if((null != observer) &&(!observers.contains(observer)))
  {
   observers.add(observer);
  }
 }
 
 // 删除观察者
 public void deleteObserver(Observer observer)
 {
  if (observers.contains(observer))
  {
   observers.remove(observer);
  }
 }
 
 // 通知观察者
 private void notifyObservers(Object data)
 {
  for (Observer observer : observers)
  {
   observer.update(data);
  }
 }
 
 //监听数据
 public void changeData(Object data)
 {
  notifyObservers(data);
 }
}

监听的数据源:
public class Student
{
 private String name;
 
 private int age;
 
 private String sex;
 
 public String getName()
 {
  return name;
 }
 
 public void setName(String name)
 {
  this.name = name;
 }
 
 public int getAge()
 {
  return age;
 }
 
 public void setAge(int age)
 {
  this.age = age;
 }
 
 public String getSex()
 {
  return sex;
 }
 
 public void setSex(String sex)
 {
  this.sex = sex;
 }
}

观察者1:
public class ObserverOne implements Observer
{
 @Override
 public void update(Object data)
 {
  if ((null != data) && (data instanceof Student))
  {
   final Student student = (Student) data;
   System.out.println("ObserverOne:"+"name=" + student.getName());
  }
 }
}
观察者2:
public class ObserverTwo implements Observer
{

 @Override
 public void update(Object data)
 {
  if((null != data) &&(data instanceof Student))
  {
   final Student student = (Student) data;
   System.out.println("ObserverTwo:"+"age="+student.getAge()+",sex="+student.getSex());
  }
 }
}

测试类:
public class Client
{
 public static void main(String[] args)
 {
  final Student student = new Student();
  student.setName("zhangsan");
  student.setSex("male");
  student.setAge(20);
  final Observable observable = new Observable();
  final ObserverOne observerOne = new ObserverOne();
  final ObserverTwo observerTwo = new ObserverTwo();
  observable.addObserver(observerOne);
  observable.addObserver(observerTwo);
  observable.changeData(student);
 }
}
执行结果:
ObserverOne:name=zhangsan
ObserverTwo:age=20,sex=male
不同的观察者对于数据的处理逻辑不同，当数据源变化的时候，不同的观察者都会收到数据.
这种方式是将变化的数据推送给所有的观察者，有些观察者会收到一些自己不需要的数据.
为了避免这种情况，可以让观察者自己取数据.

定义观察者:
public interface Observer
{
 void update(Observable observable);
}
定义可观察者:
public class Observable
{
 // 收集观察者
 private List<Observer> observers;
 
 private String name;
 
 private String sex;
 
 private int age;
 
 public Observable()
 {
  observers = new ArrayList<Observer>();
 }
 
 // 添加观察者
 public void addObserver(Observer observer)
 {
  if((null != observer) &&(!observers.contains(observer)))
  {
   observers.add(observer);
  }
 }
 
 // 删除观察者
 public void deleteObserver(Observer observer)
 {
  if (observers.contains(observer))
  {
   observers.remove(observer);
  }
 }
 
 // 通知观察者
 private void notifyObservers()
 {
  for (Observer observer : observers)
  {
   observer.update(this);
  }
 }
 
 //监听数据
 public void changeData(String name,String sex,int age)
 {
  this.name = name;
  this.age = age;
  this.sex = sex;
  notifyObservers();
 }

 public String getName()
 {
  return name;
 }

 public void setName(String name)
 {
  this.name = name;
 }

 public String getSex()
 {
  return sex;
 }

 public void setSex(String sex)
 {
  this.sex = sex;
 }

 public int getAge()
 {
  return age;
 }

 public void setAge(int age)
 {
  this.age = age;
 } 
}
观察者1:
public class ObserverOne implements Observer
{
 
 @Override
 public void update(Observable observable)
 {
  if (null != observable)
  {
   System.out.println("ObserverOne:" + "name=" + observable.getName()
     + ",sex:" + observable.getSex());
  }
 }
}
观察者2:
public class ObserverTwo implements Observer
{
 
 @Override
 public void update(Observable observable)
 {
  if (null != observable)
  {
   System.out.println("ObserverTwo:" + "age=" + observable.getAge());
  }
 } 
}
测试类:
public class Client
{
 public static void main(String[] args)
 {
  final Observable observable = new Observable();
  final ObserverOne observerOne = new ObserverOne();
  final ObserverTwo observerTwo = new ObserverTwo();
  observable.addObserver(observerOne);
  observable.addObserver(observerTwo);
  observable.changeData("zhangsan", "male", 20);
 }
}
执行结果:
ObserverOne:name=zhangsan,sex:male
ObserverTwo:age=20
为了避免数据更新后就通知，我们可以定义一个状态变量，通过该状态变量灵活的选择合适的时机接收数据.

上述是两种不同的获取数据方式，可以将两种方式结合起来使用:
public interface Observer
{
 void update(Observable observable,Object data);
}
这样可以根据实际需要灵活的使用,详细的可以参考java.util下的Observer和Observable源码.

定义观察者:
public interface Observer {

    void update(Observable o, Object arg);
}

定义可观察者:

public class Observable {
    private boolean changed = false;
    private Vector obs;

    public Observable() {
        obs = new Vector();
    }


    public synchronized void addObserver(Observer o) {
        if (o == null)
            throw new NullPointerException();
        if (!obs.contains(o)) {
            obs.addElement(o);
        }
    }


    public synchronized void deleteObserver(Observer o) {
        obs.removeElement(o);
    }

    public void notifyObservers() {
        notifyObservers(null);
    }


    public void notifyObservers(Object arg) {

        Object[] arrLocal;

        synchronized (this) {
            if (!changed)
                return;
            arrLocal = obs.toArray();
            clearChanged();
        }

        for (int i = arrLocal.length-1; i>=0; i--)
            ((Observer)arrLocal[i]).update(this, arg);
    }


    public synchronized void deleteObservers() {
        obs.removeAllElements();
    }


    protected synchronized void setChanged() {
        changed = true;
    }


    protected synchronized void clearChanged() {
        changed = false;
    }

    public synchronized boolean hasChanged() {
        return changed;
    }

    public synchronized int countObservers() {
        return obs.size();
    }
}

