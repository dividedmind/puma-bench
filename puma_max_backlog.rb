# Douches a file if server backlog is too high
class PumaMaxBacklog
  def initialize tag_path, max_backlog = 31337
    @tag_path = tag_path
    @max_backlog = max_backlog
  end

  def check
    set_tag(Puma::Server.current.backlog > @max_backlog)
  end

  def set_tag value
    if @touched != value
      FileUtils.send((value ? :touch : :rm_f), @tag_path)
      @touched = value
    end
  end
end
