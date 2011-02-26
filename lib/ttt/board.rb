class Board
  attr_reader :data
  attr_reader :size
  def initialize(x_size, y_size)
    @data = Array.new(x_size)
    y_size.times do |y|
      @data[y] = Array.new(x_size)
    end
    @x_size = x_size
    @y_size = y_size
    @size = x_size * y_size
  end
  
  def adjacent_spaces(position, for_mark)
    space_list(for_mark) do |cell|
      if abs(cell.first - position.first) < 2 && abs(cell[1] - position[1]) < 2
        true
      else
        false
      end
    end
  end
  
  def unmarked_spaces(for_mark=nil)
    space_list(for_mark) { |cell| cell.nil? }
  end
  
  def marked_spaces(for_mark=nil)
    space_list(for_mark) { |cell| !cell.nil? }
  end
  
  def space_list(for_mark=nil, &block)
    spaces = []
    @data.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        spaces << [x, y] if block.call(cell) && cell == for_mark
      end
    end
    spaces
  end
  
  def valid_move?(position)
    if self[position.first, position.last].nil?
      true
    else
      false
    end
  end
  
  def full?
    !@data.any? do |row|
      row.any? do |cell|
        cell.nil?
      end
    end
  end
  
  def move(mark, position)
    if valid_move?(position)
      self[position.first, position.last] = mark
    end
  end
  
  def to_s
    @data.collect do |row|
      row.map do |value|
        if value.nil?
          '-'
        else
          value
        end
      end.join(" | ")
    end.join("\n--+---+--\n")
  end
  
  def [](x, y)
    @data[y][x]
  end

  def []=(x, y, value)
    @data[y][x] = value
  end
  
  def rows
    @data.dup
  end
  
  def row(index)
    @data[index]
  end
  
  def column(index)
    rows.collect do |row|
      row[index]
    end
  end
  
  def columns
    (0...@x_size).collect do |index|
      column(index)
    end
  end
  
  def diagonals
    left_to_right = (0...@x_size).collect do |i|
      @data[i][i]
    end
    
    right_to_left = (0...@y_size).collect do |y|
      @data[y][@y_size-1-y]
    end
    [left_to_right, right_to_left]
  end
end
