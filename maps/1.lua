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
  nextlayerid = 10,
  nextobjectid = 44,
  properties = {
    ["speed"] = 80
  },
  tilesets = {
    {
      name = "TX Tileset Ground",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../assets/Terrain/TX Tileset Ground.png",
      imagewidth = 512,
      imageheight = 512,
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
      tilecount = 256,
      tiles = {}
    },
    {
      name = "TX Village Props",
      firstgid = 257,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "../assets/Terrain/TX Village Props.png",
      imagewidth = 1024,
      imageheight = 1024,
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
      tilecount = 1024,
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
      name = "GroundDraw",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {
        {
          x = 0, y = 0, width = 16, height = 16,
          data = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            117, 63, 63, 63, 63, 63, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            133, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            101, 0, 0, 298, 524, 525, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            117, 150, 150, 150, 150, 150, 160, 236, 0, 0, 0, 0, 0, 0, 0, 0,
            181, 166, 167, 166, 167, 168, 240, 236, 0, 0, 0, 0, 0, 0, 0, 0,
            213, 255, 255, 255, 156, 255, 256, 236, 0, 0, 0, 0, 0, 0, 0, 0,
            190, 0, 0, 0, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            206, 0, 0, 0, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            73, 0, 0, 0, 206, 2147483918, 0, 540, 0, 25, 25, 25, 25, 270, 0, 10,
            101, 0, 0, 0, 206, 2147483950, 0, 572, 0, 0, 0, 0, 0, 302, 0, 0,
            60, 2, 2, 2, 60, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            165, 77, 77, 168, 93, 167, 125, 108, 182, 77, 77, 108, 108, 76, 184, 168,
            181, 182, 167, 77, 124, 167, 183, 167, 168, 184, 92, 108, 184, 2147483863, 214, 214
          }
        },
        {
          x = 16, y = 0, width = 16, height = 16,
          data = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            433, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            56, 58, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            109, 76, 142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2147483872, 150, 150, 150,
            214, 215, 142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 197, 104, 104, 1610612829
          }
        },
        {
          x = 32, y = 0, width = 16, height = 16,
          data = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            699, 700, 701, 702, 703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            731, 732, 733, 734, 735, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            763, 764, 765, 766, 767, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            795, 796, 797, 798, 799, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            827, 828, 829, 830, 831, 0, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            859, 860, 861, 862, 863, 0, 206, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            60, 60, 62, 56, 57, 56, 222, 224, 0, 0, 0, 0, 0, 0, 0, 0,
            1610612845, 1610612861, 78, 71, 73, 2147483720, 75, 240, 0, 0, 0, 0, 0, 0, 0, 0
          }
        },
        {
          x = -16, y = 16, width = 16, height = 16,
          data = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 37, 37, 37, 37, 37,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 37, 37, 37,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          }
        },
        {
          x = 0, y = 16, width = 16, height = 16,
          data = {
            197, 182, 184, 92, 199, 166, 168, 93, 166, 199, 182, 182, 167, 2147483879, 582, 583,
            92, 76, 76, 166, 92, 166, 124, 108, 199, 200, 76, 125, 184, 2147483879, 614, 615,
            183, 183, 183, 183, 183, 183, 183, 183, 183, 183, 183, 183, 183, 97, 98, 98,
            37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          }
        },
        {
          x = 16, y = 16, width = 16, height = 16,
          data = {
            584, 231, 142, 0, 0, 0, 0, 55, 220, 220, 220, 221, 91, 104, 104, 1610612828,
            616, 231, 142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 248, 248, 248,
            98, 99, 37, 37, 37, 37, 37, 37, 37, 0, 0, 0, 0, 0, 0, 0,
            37, 37, 37, 37, 37, 37, 37, 37, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          }
        },
        {
          x = 32, y = 16, width = 16, height = 16,
          data = {
            1610612844, 1610612860, 94, 88, 89, 2147483736, 123, 240, 0, 0, 0, 0, 0, 0, 0, 0,
            248, 248, 248, 248, 248, 248, 248, 256, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          }
        }
      }
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
          y = 416,
          width = 608,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 448,
          width = 320,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 96,
          width = 224,
          height = 192,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 384,
          width = 32,
          height = 3.63636,
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
      visible = false,
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
          x = 1.66667,
          y = 288,
          width = 27.6667,
          height = 138,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "LimitV",
          type = "",
          shape = "rectangle",
          x = 3712,
          y = -1632,
          width = 1,
          height = 4000,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 417.125,
          width = 32,
          height = 190.875,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 448.986,
          width = 22.8485,
          height = 63.0145,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1216,
          y = 387.636,
          width = 32,
          height = 60.3636,
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
      visible = false,
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
          x = 480,
          y = 352,
          width = 128,
          height = 1,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 512,
          width = 160,
          height = 2,
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
      visible = false,
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
          x = 544,
          y = 320,
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
          x = 416,
          y = 384,
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
          y = 384,
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
      visible = false,
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
          y = 192,
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
          x = 912,
          y = 344.136,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "Death",
          shape = "rectangle",
          x = 0,
          y = 608,
          width = 30000,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
