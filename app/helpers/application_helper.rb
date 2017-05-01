module ApplicationHelper
  def default_meta_tags
    {
      charset: 'utf-8',
      site: 'Japan Masters Swimming Results',
      title: 'Home',
      description: 'Japan Masters Swimming Results. Freestyle, Breaststroke, Backstroke, Butterfly and Individual Medley.',
      keywords: 'swimming, results, japan, masters, freestyle, breaststroke, backstroke, butterfly, individual medley'
    }
  end

  def format_result_time(time)
    seconds = time.truncate
    minute = seconds / 60
    second = format('%02d', seconds % 60)
    millisecond = format('%.2f', time).split('.').second
    if minute.zero?
      "#{second}.#{millisecond}"
    else
      "#{minute}:#{second}.#{millisecond}"
    end
  end
end
