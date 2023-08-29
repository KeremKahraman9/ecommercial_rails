module Cache
  module RedisCache

    def read_cache
      @entity = Rails.cache.read("#{request.fullpath},#{action_name}")
      if !@entity.blank?
        @is_cached = true
        render "api/#{controller_name}/#{action_name}.json.jbuilder",status: :ok
      else
        @is_cached = false
      end
    end

    def remove_cache
      keys = Rails.cache.redis.keys.select {|key| key.include?(controller_name)}
      keys.each do |key|
          Rails.cache.delete(key) 
      end
    end

    def write_cache(entity)
      Rails.cache.write("#{request.fullpath},#{action_name}",entity,expires_in: 60.minutes)
    end

  end
end