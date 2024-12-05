#!/usr/bin/env -S julia -t 4 -- project

open("input.txt") do f
  m = readlines(f)
  num_row::Int = length(m)
  num_col::Int = length(m[1])

  map = zeros(Int, num_row, num_col)
  map_cnt = 1
  numbers = []
  cnt = 0
  gear_sum = 0

  for i in range(1, num_row)
    start::Int = 0
    stop::Int = 0
    check_trigger::Bool = false
    for j in range(1, num_col)
      if isnumeric(m[i][j]) && start == 0
        start = j
        stop = j
      elseif isnumeric(m[i][j])
        stop = j
      elseif (!isnumeric(m[i][j]) && start != 0)
        check_trigger = true
      end
      if j == num_col && start != 0
        check_trigger = true
      end

      if check_trigger
        valid = false
        for k in range(max(1,i-1), min(num_row,i+1))
          test = m[k][max(1,start-1):min(num_col,stop+1)]
          hits = findall(Regex("[^0-9.]"), test)
          if length(hits) > 0
            valid = true
            break
          end
        end

        if valid
          num = parse(Int, m[i][start:stop])
          cnt += num
          push!(numbers, num)
          map[i,start:stop] .= map_cnt
          map_cnt += 1
        end

        start = 0
        stop = 0
        check_trigger = false
      end
    end
  end

  for i in range(1, num_row)
    for star in findall("*", m[i])
      nbr = []
      for k in range(max(1,i-1), min(num_row,i+1))
        push!(nbr, map[k,max(1,star.start-1):min(num_col,star.stop+1)])
      end
      un_nbr = sort!(unique(reduce(vcat, nbr)))
      if length(un_nbr) == 3
        gear_sum += numbers[un_nbr[2]] * numbers[un_nbr[3]]
      end
    end
  end
  println("Sum of all part numbers: ", cnt)
  println("Sum of all gear ratios ", gear_sum)
end