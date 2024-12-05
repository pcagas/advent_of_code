#!/usr/bin/env -S julia -t 4 -- .

max_values = (red = 12, green = 13, blue = 14)

open("input.txt") do f
  cnt_possible = 0
  product_sum = 0

  while ! eof(f)
    is_possible = true
    line = readline(f)

    id_str, data = split(line, ": ")
    id = parse(Int, split(id_str, " ")[2])

    min_red = 0
    min_blue = 0
    min_green = 0

    for draw in split(data, "; ")
      for cubes in split(draw, ", ")
        num_str, color = split(cubes, " ")
        num = parse(Int, num_str)
        if num > max_values[Symbol(color)]
          is_possible = false
        end
        if color == "blue" && num > min_blue
          min_blue = num
        end
        if color == "green" && num > min_green
          min_green = num
        end
        if color == "red" && num > min_red
          min_red = num
        end
      end
    end
    if is_possible
      cnt_possible += id
    end
    product_sum += min_green * min_red * min_blue
  end
  println("Number of possible: ", cnt_possible)
  println("Product sum: ", product_sum)
end