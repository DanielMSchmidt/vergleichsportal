module HomeHelper

  def getCompleteStatistics
    statistics = {
      labels: getLabels,
      compares: getCompares,
      searches: getSearches
    }
    return statistics
  end

  def getLabels
    getLastWeek.map{ |date| date.strftime("%b %d") }.to_s
  end

  def getCompares
    compares_per_day = []
    getLastWeek.each do |day|
      compares_per_day << Compare.where(created_at: day.beginning_of_day..day.end_of_day).count
      puts compares_per_day
    end
    compares_per_day.to_s
  end

  def getSearches
    queries_per_day = []
    getLastWeek.each do |day|
      queries_per_day << SearchQuery.where(created_at: day.beginning_of_day..day.end_of_day).count
    end
    queries_per_day.to_s
  end

  def getLastWeek
    7.day.ago.to_date..Date.today
  end
end
