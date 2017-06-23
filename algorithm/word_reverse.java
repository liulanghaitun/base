 题目: 字符串反序输出

输入:today is a good day!

输出:day! good a is today

思路:

1.提取构造反序输出模板

如果是空字符，则用0代替，如果不是空字符，则用1代替.

2.提取其中的单个字符串

通过去除前后空格，然后递归判断内部是否还有空字符，如果有递归，否则返回.构造字符串序列.

3.将模板与提取后的字符串适配

将字符串序列与模板适配，0和1用字符序列替换，得到反转序列.


/**
 * 字符串反转
 *
 * @author renwei
 *
 */
public class ReserverString
{
	private static final char ZERO = '0';
	private static final char ONE = '1';
	private static final char SPACE = ' ';

	/**
	 * 反转字符串
	 *
	 * @param input
	 * 输入字符串
	 * @return 反转后的字符串
	 */
	private static String reserverString(String input)
	{
		final StringBuilder strBuilder = new StringBuilder();
		final String template = constructTemplate(input);
		extractStr(input, strBuilder);
		return adapterTemplate(strBuilder, template);
	}

	/**
	 * 构造模板
	 *
	 * @param input
	 * 输入字串
	 * @return 反转后模板
	 */
	private static String constructTemplate(String input)
	{
		final StringBuilder base = new StringBuilder();
		for (int index = 0; index < input.length(); index++)
		{
			if (input.charAt(index) == SPACE)
			{
				base.append(ZERO);
			}
			else
			{
				base.append(ONE);
			}
		}
		return base.reverse().toString();
	}

	/**
	 * 提取单个字串
	 *
	 * @param value
	 * 输入字串
	 * @param result
	 * 收集实际字串
	 */
	private static void extractStr(String value, StringBuilder result)
	{
		String trimStr = value.trim();
		final int index = trimStr.indexOf(" ");
		if (index == -1)
		{
			result.append(trimStr);
		}
		else
		{
			final String baseStr = trimStr.substring(0, index);
			final String rest = trimStr.substring(index, trimStr.length());
			extractStr(rest, result);
			result.append(baseStr);
		}
	}

	/**
	 * 适配模板与字符串
	 *
	 * @param value
	 * @param template
	 * @return
	 */
	private static String adapterTemplate(StringBuilder value, String template)
	{
		final StringBuilder result = new StringBuilder();
		int base = 0;
		for (int index = 0; index < template.length(); index++)
		{
			if (template.charAt(index) == ZERO)
			{
				result.append(" ");
			}
			else if (template.charAt(index) == ONE)
			{
				result.append(value.toString().charAt(base++));
			}
		}
		return result.toString();
	}

	/**
	 * 测试
	 *
	 * @param args
	 */
	public static void main(String[] args)
	{
		String input = " today is a good day! ";
		System.out.println("input==" + input);
		final String result = reserverString(input);
		System.out.println("result==" + result);
	}
}

结果输出:

input== today is a good day!
result== day! good a is today 
