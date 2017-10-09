def method_1
  begin
    method_2
  rescue => e
    puts e.backtrace
  end
end

def method_2
  # ZeroDivisionErrorを発生させる
  1 / 0
end

method_1
