Controls = {}

function Controls:load()
    self.left = {
        x = 50 , y = WindowH - 100 ,
        w= 50 , h = 50
    }
    self.right = {
        x = 110 , y = WindowH - 100,
        w= 50 , h = 50
    }
end

function Controls:draw()
    love.graphics.rectangle("fill" , self.left.x , self.left.y , self.left.w , self.left.h)
    love.graphics.rectangle("fill" , self.right.x , self.right.y , self.right.w , self.right.h)
end

return Controls