class EventsController < ApplicationController
  def index
    now = Time.now
    @from = parse_time(params[:from], (now - 1.day).beginning_of_day)
    @till = parse_time(params[:till], (now + 1.day).end_of_day)

    @events = Event.get(
      time_from: @from.to_i,
      time_till: @till.to_i,
      host: params[:host],
      priority: params[:priority].to_i
    )
  end

  private

  def parse_time(time, defval)
    if time.present?
      if time =~ /\A\d+\z/
        Time.at(time.to_i)
      else
        Time.parse(time)
      end
    else
      defval
    end
  end
end
