require './constants.rb'

task :download do
  1.upto(47) {|i|
    pref = sprintf('%02d', i)
    URLS.each {|url|
      url = url.sub("${pref}", pref)
      src_path = "#{SRC_DIR}/#{pref}.zip"
      sh "curl -o #{src_path} #{url}"
      sh "unzip -d #{SRC_DIR} #{src_path}"
      sh "rm #{src_path}"
    }
  }
end

task :clean do
  sh "rm #{SRC_DIR}/*"
end

task :pos do
  1.upto(47) {|i|
    first = true
    pref = sprintf('%02d', i)
    path = "#{SRC_DIR}/mt_#{THEME}_pos_pref#{pref}.csv"
    File.foreach(path) {|l|
      if first
        first = false
      else
        r = l.strip.split(',')
        id = r[0..4].join 
        coords = r[7..8]
        print <<-EOS
{"type": "Feature", "geometry": {"type": "Point", "coordinates": [#{coords.join(',')}]}, "properties": {"id": "#{id}"}, "tippecanoe": {"layer": "#{LAYER}"}}
        EOS
      end
    }
  }
end

task :csv do
  print "id,jukyo\n"
  1.upto(47) {|i|
    first = true
    pref = sprintf('%02d', i)
    path = "#{SRC_DIR}/mt_#{THEME}_pref#{pref}.csv"
    File.foreach(path) {|l|
      if first
        first = false
      else
        r = l.strip.split(',')
        jukyo = r[11..12]
        jukyo.delete('')
        id = r[0..4].join
        print <<-EOS
#{id},#{jukyo.join('-')}
        EOS
      end
    }
  }
end

task :tiles do
  sh <<-EOS
rake csv > match.csv; \
rake pos | tippecanoe --minimum-zoom=3 --maximum-zoom=13 --base-zoom=13 \
--force -r2.0 --drop-densest-as-needed --output=a.mbtiles; \
tile-join -f --no-tile-size-limit --output=b.mbtiles \
--maximum-zoom=12 a.mbtiles; \
tile-join -f --no-tile-size-limit --output=c.mbtiles \
--minimum-zoom=13 --csv=match.csv a.mbtiles; \
tile-join -f --no-tile-size-limit --no-tile-compression \
--output-to-directory=docs/zxy b.mbtiles c.mbtiles; \
rm match.csv a.mbtiles b.mbtiles c.mbtiles
  EOS
end

task :style do
  sh <<-EOS
charites build style.yml docs/style.json
  EOS
end

task :host do
  sh <<-EOS
budo -d docs
  EOS
end

