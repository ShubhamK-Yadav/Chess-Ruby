class GameWindow
	def initialize(title:, width:, height:, background:)
		@title = title
		@width = width
		@height = height
		@background = background
	end

	def show_window
		Ruby2D::Window.set(
			title: @title,
			width: @width,
			height: @height,
			background: @background
		)
	end
end