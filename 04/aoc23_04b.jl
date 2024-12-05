#!/usr/bin/env -S julia -t 4 -- project

open("input.txt") do f
  m = readlines(f)
  num_rows = length(m)
  num_cards = ones(Int, num_rows)

  point_cnt::Int = 0
  total_cnt::Int = 0

  for i in range(1,num_rows)
    points::Int = 0
    num_matches::Int = 0

    data = split(m[i], ":")[end]
    winning_nums_str, nums_str = split(data, "|")
    winning_nums = parse.(Int, filter(!isempty, split(winning_nums_str, " ")))
    nums = parse.(Int, filter(!isempty, split(nums_str, " ")))

    for n in nums
      if n in winning_nums
        num_matches += 1
      end
    end
    if num_matches > 0
      point_cnt += 2^(num_matches-1)
      for j in range(i+1, min(num_rows, i+num_matches))
        num_cards[j] += num_cards[i]
      end
    end
  end
  println("Number of points: ", point_cnt)
  println("Total number of cards: ", sum(num_cards))
end