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
    '"January","February","March","April","May","June","July"'
  end

  def getCompares
    '65,59,90,81,56,55,40'
  end

  def getSearches
    '28,48,40,19,96,27,100'
  end
end
