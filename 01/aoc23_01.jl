options = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "[0-9]"]

open("input.txt") do f
  line = 0
  cnt = 0
  while ! eof(f)
    line = readline(f)

    firsts = []
    lasts = []

    for opt in options
      idxs = findall(Regex(opt), line)
      if length(idxs) > 0
        push!(firsts, idxs[1].start)
        push!(lasts, idxs[end].stop)
      else
        push!(firsts, Inf)
        push!(lasts, -Inf)
      end
    end

    if argmin(firsts) == 10
      cnt += 10 * parse(Int, line[firsts[10]])
    else
      cnt += 10 * argmin(firsts)
    end

    if argmax(lasts) == 10
      cnt += parse(Int, line[lasts[10]])
    else
      cnt += argmax(lasts)
    end

  end
  println(cnt)
end