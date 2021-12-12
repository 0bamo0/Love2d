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
  nextlayerid = 8,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "terrain",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 22,
      image = "../assets/terrain.png",
      imagewidth = 704,
      imageheight = 352,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 242,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 1,
      name = "Ground",
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
          x = 320,
          y = 288,
          width = 160,
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
          x = 366,
          y = 224,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnNumber"] = 1,
            ["speed"] = 80
          }
        },
        {
          id = 5,
          name = "Area",
          type = "pig",
          shape = "rectangle",
          x = 418,
          y = 222,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["spawnNumber"] = 0,
            ["speed"] = 80
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
          x = 608,
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
