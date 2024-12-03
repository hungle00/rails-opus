class ExportCsvChannel < ApplicationCable::Channel
  def subscribed
    stream_from "export_csv"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
