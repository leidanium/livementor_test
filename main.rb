# import
require 'json'
require 'csv'

# return file data
def get_json_file(file_name)
    input_f = File.read("users.json")
    data = JSON.parse(input_f)
    data
end

# extract header from Hash keys
def csv_header(first_line)
    csv_header = []

    first_line.each do | k, v|
        if v.class == Hash
            v.each do |kk, vv|
                if vv.class == Hash
                    vv.each do |kkk, vvv|
                        csv_header << k.to_s + '.'+ kk.to_s + '.'+ kkk.to_s
                    end
                else
                    csv_header << k.to_s + '.'+ kk.to_s
                end
            end
        else
            csv_header << k
        end
    end
    csv_header
end

# extract one line of data
def csv_line(data_line)
    line = []

    data_line.each do |k, v|
        if v.class == Hash
            v.each do |kk, vv|
                if vv.class == Hash
                    vv.each do |kkk, vvv|
                        line << vvv.to_s
                    end
                else
                    line << vv
                end
            end
        elsif v.class == Array
            line << v.join(",")
        else
            line << v
        end
    end
    line
end

# create csv file from data
def create_csv_from_data(output_file, data)
    CSV.open(output_file, "wb") do |csv|
        csv << csv_header(data.first)
        data.each do | i |
            csv << csv_line(i)
        end
    end
end

file_input_name = 'users.json'
file_output_name = 'users_2.csv'

data = get_json_file(file_input_name)
create_csv_from_data(file_output_name, data)