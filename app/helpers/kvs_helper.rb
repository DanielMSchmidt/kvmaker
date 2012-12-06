module KvsHelper
  def calculate_latex_normal_form(kv)
    str = ''
    str += add_lines(kv.fields.split(", "), kv.values.split(", ")).chomp(' &+ ')
    logger.debug "the sting is: #{str}"
    logger.debug "the fields were #{kv.fields.split(', ')}"
    logger.debug "the input was #{kv.values.split(', ')}"
    return str
  end

  def add_lines(fieldnames, data)
    str = ''
    data.each do |line|
      str += '( '
      i = 0
      values = line.split(" ")
      values.each do |value|
        str += add_value(fieldnames, value, i)
        i += 1
      end
      str = str.chomp(' * ')
      str += ' ) \\\\
      &+ '
    end
    return str
  end

  def add_value(fieldnames, value, i)
    get_output(fieldnames, value, i) + ' * '
  end

  def calculate_latex_table(kv)
    width = kv.fields.split(", ").length
    str = print_diagram_header(kv.fields.split(", "))
    print_each_combination(width)
    str += print_diagram_footer
    return str
  end

  def print_diagram_header(fields)
    str = '\begin{center}
    \begin{tabular}{XXXXX}
    '
    str += fields.join(" & ")
    str += '\\\\
     '

    return str
  end

  def print_each_combination(width)
    str = ''
    i = 0
    while (i < 2 ** width)
      str += i.to_s(2).split('').join(' & ')
      str += ' \\\\
      '
      i += 1
    end
  end
  def print_diagram_line(fields, values)
    i = 0
    str = ''
    values.split(" ").each do |x|
      logger.debug "line #{i} => #{x}"
      str += "#{get_output(fields, x, i)} & "
      i += 1
    end
    return str.chomp(" &") + " \\\\"
  end


  def print_diagram_footer
    return '\end{tabular}
            \end{center}'
  end

  def get_output(fields, value, i)
    if value == '1'
      "#{fields[i]}"
    else
      "\\overline{#{fields[i]}}"
    end
  end
end
