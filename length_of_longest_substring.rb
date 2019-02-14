 require "pry"
# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  size = s.size
  sub = ""
  max_length = 0
  max_sub = ""
  (0...size).each do |i|
    sub = s[i]
    ((i + 1 )...size).each do |j|
      if sub.index(s[j])
        max_length = [sub.size,max_length].max
        # if max_length == sub.size
        #   max_sub = sub
        # end
        break
      else
        sub << s[j]
      end
    end
    max_length = [sub.size,max_length].max
    # if max_length == sub.size
    #   max_sub = sub
    # end
  end
  # puts max_sub
  max_length
end

=begin

题目：

给定一个字符串，找出不含有重复字符的 最长子串 的长度。

示例：

给定 "abcabcbb" ，没有重复字符的最长子串是 "abc" ，那么长度就是3。

给定 "bbbbb" ，最长的子串就是 "b" ，长度是1。

给定 "pwwkew" ，最长子串是 "wke" ，长度是3。请注意答案必须是一个子串，"pwke" 是 子序列 而不是子串。

思路：

从前往后依次扫描字符串，初始化最长字符串长度是length_max = 0。不含重复元素的子串初始坐标是start = 0
如果扫描到第j个字符 c, mark[c] = -1，那么继续往后扫描，并且更新mark[c] = j
如果扫描到第j个字符c，mark[c] != -1,这个时候分两种情况，
第一种情况是这个字符之前虽然出现过了，但是它在此次子串的起始位置之前，也就是说mark[c] < start。那么更新mark[c] = j
第二种情况是mark[c] >= start，那么就代表c之前出现了，并且出现的位置在当前子串中。
那么我们会得到一个新的长度length = j - mark[c], 比较length与length_max，如果length > length_max, 那么更新length_max = length。
并且更新start = mark[c] + 1
更新mark[c] = j
举个例子，对于"abcabcbb"，按照上面的步骤扫描,

扫描到'a'时，设置mark[97] = 0,
依次设置mark[98]=1, mark[99] = 2,
当扫描到第四位上的'a'时，发现mark[97] != -1，并且mark[97] 是0，mark[97] >= start，
所以会产生第一个没重复的子串的长度，3 - 0 = 3， 更新length_max = 3
更新start = mark[97] + 1 = 1
更新mark[97] = 3
继续扫描'b',发现mark[98] != 0，mark[98]是1，mark[98] > start，所以产生下一个长度length = 4 - 1 = 3, length_max 还是3.
后面扫描类似，此处不再赘述

=end

def length_of_longest_substring_2(s)
  solution = base = 0
  index = Hash.new { |hash, key| hash[key] = -1 }
  s.length.times do | cur|
    base = [base, index[s[cur]] + 1].max
    solution = [solution, cur - base + 1].max
    index[s[cur]] = cur
  end
  solution
end

puts length_of_longest_substring_2(ARGV[0])
