SRC_DIR = 'src'
THEME = 'rsdtdsp_rsdt'
HOST = 'gov-csv-export-public.s3.ap-northeast-1.amazonaws.com'
URLS = [
  "https://#{HOST}/mt_#{THEME}_pos/pref/mt_#{THEME}_pos_pref${pref}.csv.zip",
  "https://#{HOST}/mt_#{THEME}/pref/mt_#{THEME}_pref${pref}.csv.zip"
]
LAYER = 'jukyo'

