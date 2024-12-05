#!/usr/bin/env -S julia -t 4 -- project

open("input.txt") do f
  lowest_loc = Inf
  lowest_seed::Int = 0

  row = readline(f)
  seeds_in = parse.(Int, split(row, " ")[2:end])
  part_two = false
  if part_two
    seeds = collect(seeds_in[1]:seeds_in[1]+seeds_in[2])
    for i in 2:Int(length(seeds_in)/2)
      seeds = reduce(vcat, (seeds, collect(seeds_in[2*i-1]:seeds_in[2*i-1]+seeds_in[2*i])))
    end
  else
    seeds = seeds_in
  end

  maps = [[] for n in 1:7]
  map_ptr::Int = 0

  while ! eof(f)
    row = readline(f)
    if isempty(row)
      map_ptr += 1
      readline(f)
    else
      push!(maps[map_ptr], parse.(Int, split(row, " ")))
    end
  end

  for seed in seeds
    val_in = seed
    val_out = seed
    for map in maps
      val_out = val_in
      for rule in map
        if val_in >= rule[2] && val_in < rule[2]+rule[3]
          val_out += rule[1]-rule[2]
          break
        end
      end
      val_in = val_out
    end

    if val_out < lowest_loc
      lowest_loc = val_out
      lowest_seed = seed
    end
  end

  println("Seed with the lowest location: ", lowest_seed)
  println("Lowest location: ", lowest_loc)
end