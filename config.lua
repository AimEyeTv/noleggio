
config = {}


config.customplate = true
config.plate = "JIBO" -- fatto da Jibo
config.blip = 595
config.blipcolor = 37

config.noleggio = {
    ['garagecentrale'] = {
        ped = {
            label = 'Garage Centrale',
            model = "a_f_y_eastsa_03", --204.56909179688, -848.94152832031, 30.638505935669, 341.61999511719
            ['x'] = 204.51,
            ['y'] = -848.905 , 
            ['z'] =  30.6,
            ['h'] = 341.40
        },
        SpawnCar = {
            ['x'] = 201.84, -- 201.84976196289, -843.95678710938, 30.586740493774, 252.73707580566
            ['y'] = -843.95,
            ['z'] = 30.58,
            ['h'] = 252.73
        },
        
    },

    ['ospedale'] = {
        ped = {
            label = 'Ospedale',
            model = "a_f_y_eastsa_03", --277.04180908203, -590.65747070312, 43.296527862549, 61.284130096436
            ['x'] = 277.01,
            ['y'] = -590.905,
            ['z'] =  43.29,
            ['h'] = 70.88
        },
        SpawnCar = {    --274.59564208984, -589.34204101562, 43.151935577393, 337.86672973633
            ['x'] = 274.84, 
            ['y'] = -589.95,
            ['z'] = 43.58,
            ['h'] = 337.73
        },
    },

    ['polizia'] = {
        ped = {
            label = 'Stazione polizia',
            model = "csb_dix", -- 412.1252746582, -980.65808105469, 29.421789169312, 91.036285400391
            ['x'] = 412.1252746582,
            ['y'] = -980.65,
            ['z'] =  29.421789,
            ['h'] = 91.10
        },
        SpawnCar = {    -- 404.63565063477, -981.98443603516, 29.286926269531, 357.84777832031
            ['x'] = 404.63, 
            ['y'] = -981.984,
            ['z'] = 29.28692,
            ['h'] = 357.8
        }
    }
}

config.VehicleList = {
    oracle = {
        ['title'] = 'Oracle',
        ['desc'] = 'Noleggia questa macchina a $600',
        ['icon'] = 'car',
        ['prezzo'] = 600,
        ['model'] = 'oracle2'
    },
    bmx = {
        ['title'] = 'Bmx',
        ['desc'] = 'Noleggia questa bmx a $50',
        ['icon'] = 'bicycle',
        ['prezzo'] = 200,
        ['model'] = 'bmx'
    },
    pounder = {
        ['title'] = 'Pounder',
        ['desc'] = 'Noleggia questo camion a $1500',
        ['icon'] = 'truck',
        ['prezzo'] = 1500,
        ['model'] = 'pounder'
    },
    faggio = {
        ['title'] = 'Faggio',
        ['desc'] = 'Noleggia questo scooter a $300',
        ['icon'] = 'car',
        ['prezzo'] = 400,
        ['model'] = 'faggio'
    }
}