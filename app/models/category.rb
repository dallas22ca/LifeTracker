class Category < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :name, scope: :user_id
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def time_vs_quantity(start = 30.days.ago, finish = Time.zone.now)
    start = start - 1.day
    time_vs_quantity = user.ratings.includes(:event).where("category_id = ? and events.date >= ? and events.date <= ?", id, start, finish).order("events.date asc").map{ |r| 
      {
        x: r.event.date.to_i * 1000,
        y: r.quantity,
        notes: r.event.notes,
        date: r.event.date.strftime("%A, %b %-d")
      }
    }
    
    time_vs_quantity.sort_by { |a| a[:x] }
  end
  
  def self.chart_all(category_ids, goal_id, start = 30.days.ago, finish = Time.zone.now)
    yAxis = []
    series = []
    colours = ["#008FDC", "#51B85A", "#872F6E", "#742DB0"]
    
    Category.find(category_ids).each_with_index do |category, index|
      is_goal = category.id == goal_id
      colour = is_goal ? "#E08B35" : colours[index]
      
      axis = {
        title: {
          text: category.name,
          style: {
            color: colour
          }
        },
        labels: {
          style: {
            color: colour
          }
        },
        opposite: !is_goal
      }
      
      sery = {
        name: category.name,
        color: colour,
        type: is_goal ? "line" : "line",
        yAxis: index,
        data: category.time_vs_quantity(start, finish),
        index: is_goal ? 2 : 3,
      }
      
      yAxis.push axis
      series.push sery
    end
    
    {
      title: {
        text: "#{Category.find(goal_id).name} Over Time"
      },
      xAxis: {
        type: 'datetime',
        dateTimeLabelFormats: {
          second: ' ',
          minute: ' ',
          hour: ' ',
          day: '%b %e',
          week: '%b %e',
          month: '%b %e',
          year: '%b %e'
        }
      },
      yAxis: yAxis,
      series: series
    }
  end
  
  def compare_to_goal
    user.goal
  end
end
