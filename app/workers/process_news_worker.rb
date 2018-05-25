class ProcessNewsWorker
  include Sidekiq::Worker

  def perform(item_id)
    item = Item.find(item_id)
    if item
      item.get_ner
    end
    # Do something
  end
end
