生产者-消费者模型是一个并发协作模型。
生产者在共享数据区写数据，消费者从共享数据区读取数据。
如果共享区没有数据，消费者等待生产者存放数据。如果共享区有数据，消费者获取数据并且等待生产者存放数据。



/**
 * 生产者
 *
 * @author renwei
 *
 */
public class Producer extends Thread {

	// 共享数据区
	private ShareArea shareArea;

	// 产生随机数
	private final Random random = new Random();

	public Producer(ShareArea share) {
		shareArea = share;
	}

	@Override
	public void run() {
		while (true) {
			shareArea.setShareValue(produceData());
			sleepTime(500);
		}
	}

	private void sleepTime(long time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			System.out.println(e.toString());
		}
	}

	//负责产生数据
	private int produceData() {
		final int value = random.nextInt(500);
		System.out.println("Producer put a value: " + value);
		return value;
	}
}



/**
 * 消费者
 *
 * @author renwei
 *
 */
public class Consumer extends Thread {

	// 数据共享区
	private ShareArea shareArea;

	public Consumer(ShareArea share) {
		shareArea = share;
	}

	@Override
	public void run() {
		while (true) {
			final int result = shareArea.getShareValue();
			consumerData(result);
			sleepTime(500);
		}
	}

	private void sleepTime(long time) {
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			System.out.println(e.toString());
		}
	}

	// 处理数据
	private void consumerData(int value) {
		System.out.println("Consumer get a value: " + value + "n");
	}
}



/**
 * 共享数据区
 *
 * @author renwei
 *
 */
public class ShareArea {

	// 共享数据
	private int shareValue = -1;

	// 是否已经存储
	private boolean isStored = false;

	// 对象锁
	private final byte[] lock = new byte[0];

	public void setShareValue(int value) {
		synchronized (lock) {
			while (isStored) {
				waitForOperation();
			}
			shareValue = value;
			isStored = true;
			lock.notifyAll();
		}
	}

	public int getShareValue() {
		synchronized (lock) {
			while (!isStored) {
				waitForOperation();
			}
			isStored = false;
			lock.notifyAll();
			return shareValue;
		}
	}

	private void waitForOperation() {
		try {
			lock.wait();
		} catch (InterruptedException e) {
			System.out.println(e.toString());
		}
	}

}



/**
 * 测试类
 *
 * @author renwei
 *
 */
public class Client {

	public static void main(String[] args) {
		final ShareArea shareArea = new ShareArea();
		final Consumer consumer = new Consumer(shareArea);
		final Producer producer = new Producer(shareArea);
		producer.start();
		consumer.start();
	}

}

 执行结果:

Producer put a value: 368
Consumer get a value: 368

Producer put a value: 429
Consumer get a value: 429

Producer put a value: 154
Consumer get a value: 154

Producer put a value: 412
Consumer get a value: 412

Producer put a value: 69
Consumer get a value: 69

Producer put a value: 348
Consumer get a value: 348

Producer put a value: 403
Consumer get a value: 403

Producer put a value: 247
Consumer get a value: 247

Producer put a value: 437
Consumer get a value: 437

Producer put a value: 408
Consumer get a value: 408

Producer put a value: 13
Consumer get a value: 13

Producer put a value: 314
Consumer get a value: 314 
