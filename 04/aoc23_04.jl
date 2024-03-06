#!/usr/bin/env -S julia -t 4 -- project

function check_card(m::Vector{String}, id::Int)
  num_row::Int = length(m)
  points::Int = 0
  cnt::Int = 1
  matches::Int = 0
  line = m[id]
  data = split(line, ":")[end]

  winning_nums_str, nums_str = split(data, "|")
  winning_nums = parse.(Int, filter(!isempty, split(winning_nums_str, " ")))
  nums = parse.(Int, filter(!isempty, split(nums_str, " ")))

  for n in nums
    if n in winning_nums
      matches += 1
    end
  end
  if matches > 0
    points = 2^(matches-1)
    for j in range(id+1, min(num_row,id+matches))
      sub_points, sub_cnt = check_card(m, j)
      cnt += sub_cnt
    end
  end

  return points, cnt
end

open("input.txt") do f
  m = readlines(f)
  num_row::Int = length(m)

  point_cnt::Int = 0
  total_cnt::Int = 0

  for i in range(1,num_row)
    points, cnt = check_card(m, i)
    point_cnt += points
    total_cnt += cnt
  end
  println("Number of points: ", point_cnt)
  println("Total number of cards: ", total_cnt)
end