return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.7.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 9,
  nextobjectid = 22,
  properties = {
    ["speed"] = 80
  },
  tilesets = {},
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 1,
      name = "GroundDraw",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Ground",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "Ground",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 352,
          width = 1e+06,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "PlayerSpawn",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "LimitV",
          type = "",
          shape = "rectangle",
          x = -1,
          y = -2000,
          width = 1,
          height = 4000,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "LimitV",
          type = "",
          shape = "rectangle",
          x = 1312,
          y = -1824,
          width = 1,
          height = 4000,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "Platforms",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 3,
          name = "Platform",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 288,
          width = 256,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "Entity",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "Unit",
          type = "pig",
          shape = "rectangle",
          x = 384,
          y = 256,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["health"] = 2,
            ["spawnNumber"] = 1,
            ["speed"] = 80
          }
        },
        {
          id = 5,
          name = "Area",
          type = "pig",
          shape = "rectangle",
          x = 397,
          y = 153,
          width = 136,
          height = 64,
          rotation = 0,
          visible = false,
          properties = {
            ["health"] = 2,
            ["spawnNumber"] = 0,
            ["speed"] = 80
          }
        },
        {
          id = 11,
          name = "",
          type = "sign",
          shape = "rectangle",
          x = 256,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 2
          }
        },
        {
          id = 12,
          name = "Welcome",
          type = "sign",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = 1
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "LevelControl",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 7,
          name = "",
          type = "Spawn",
          shape = "rectangle",
          x = 114.545,
          y = 124.364,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "Next",
          shape = "rectangle",
          x = 768,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
