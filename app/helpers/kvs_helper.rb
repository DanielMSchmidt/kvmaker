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
    str = print_diagram_header(kv.fields.split(", "), kv.input)
    str += print_each_combination(kv.input)
    str += print_diagram_footer
    return str
  end

  def print_diagram_header(fields, input)
    input_values = ''
    input.times{ input_values += 'c'}
    input_values += '|'
    (fields.length - input).times{ input_values += 'c' }
    str = "\\begin{center}
    \\begin{tabular}{#{input_values}}
    "
    str += fields.join(" & ")
    str += '\\\\
     '

    return str
  end

  def print_each_combination(width)
    str = ''
    i = 0
    while (i < 2 ** width)
      value = i.to_s(2)
      value = add_zeros(value, width) if value.length < width
      str += value.split('').join(' & ')
      str += ' \\\\
      '
      i += 1
    end
    return str
  end

  def add_zeros(value, width)
    out = value
    while (out.length < width) do
      out = "0" + out
    end
    return out
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

  def generate_KV_diagrams(kv)
    str = ''
    (kv.fields.split(", ").length - kv.input).times{|x| str += generate_KV_diagram(kv, x)}
    return str
  end

  def generate_KV_diagram(kv, number)
    str = "\\input kvmacros
    \\karnaughmap{#{kv.input}}{$#{generate_KV_function(kv, number)}:$}{#{generate_KV_inputs(kv)}}{#{generate_KV_values(kv)}}
    {

    }
    "
  end

  def generate_KV_function(kv, number)
    str = "#{kv.fields.split(", ")[(kv.input + number)]}( "
    str += kv.fields.split(", ")[0..(kv.input - 1)].join(", ")
    str.chomp(", ")
    return str + ")"
  end

  def generate_KV_inputs(kv)
    str = ''
    kv.fields.split(", ")[0..(kv.input - 1)].each{|x| str += "{$#{x}$}"}
    return str
  end

  def generate_KV_values(kv)
    str = ''
    (2 ** kv.input).times{|x| str += '0'}
    return str.gsub(/\s+/, "")
  end
end
