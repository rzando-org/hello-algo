=begin
File: coin_change.rb
Created Time: 2024-05-29
Author: Xuan Khoa Tu Nguyen (ngxktuzkai2000@gmail.com)
=end

### 零钱兑换：动态规划 ###
def coin_change_dp(coins, amt)
  n = coins.length
  _MAX = amt + 1
  # 初始化 dp 表
  dp = Array.new(n + 1) { Array.new(amt + 1, 0) }
  # 状态转移：首行首列
  (1...(amt + 1)).each { |a| dp[0][a] = _MAX }
  # 状态转移：其余行和列
  for i in 1...(n + 1)
    for a in 1...(amt + 1)
      if coins[i - 1] > a
        # 若超过目标金额，则不选硬币 i
        dp[i][a] = dp[i - 1][a]
      else
        # 不选和选硬币 i 这两种方案的较小值
        dp[i][a] = [dp[i - 1][a], dp[i][a - coins[i - 1]] + 1].min
      end
    end
  end
  dp[n][amt] != _MAX ? dp[n][amt] : -1
end

### 零钱兑换：空间优化后的动态规划 ###
def coin_change_dp_comp(coins, amt)
  n = coins.length
  _MAX = amt + 1
  # 初始化 dp 表
  dp = Array.new(amt + 1, _MAX)
  dp[0] = 0
  # 状态转移
  for i in 1...(n + 1)
    # 正序遍历
    for a in 1...(amt + 1)
      if coins[i - 1] > a
        # 若超过目标金额，则不选硬币 i
        dp[a] = dp[a]
      else
        # 不选和选硬币 i 这两种方案的较小值
        dp[a] = [dp[a], dp[a - coins[i - 1]] + 1].min
      end
    end
  end
  dp[amt] != _MAX ? dp[amt] : -1
end

### Driver Code ###
if __FILE__ == $0
  coins = [1, 2, 5]
  amt = 4

  # 动态规划
  res = coin_change_dp(coins, amt)
  puts "凑到目标金额所需的最少硬币数量为 #{res}"

  # 空间优化后的动态规划
  res = coin_change_dp_comp(coins, amt)
  puts "凑到目标金额所需的最少硬币数量为 #{res}"
end
