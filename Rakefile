require 'encrypted_strings'

task :enc, [:problem, :password] do |t, args|
    pass    = args[:password]
    problem = args[:problem]
    dir     = "#{problem}.hs"
    files   = FileList.new("#{dir}/*.hs")

    files.each do |file|
        fileOut = "#{file}_enc"
        puts "Encrypting #{file} => #{fileOut} with password #{pass}..."

        contents = File.read(file)
        encrypted = contents.encrypt(
            :symmetric,
            :algorithm => 'des-ecb',
            :password => pass
        )

        File.open(fileOut, 'w') do |f|
            f.write(encrypted)
        end
    end
end

task :dec, [:problem, :password] do |t, args|
    pass    = args[:password]
    problem = args[:problem]
    dir     = "#{problem}.hs"
    files   = FileList.new("#{dir}/*.hs_enc")

    files.each do |file|
        base = File.basename(file, '.hs_enc')
        fileOut = "#{dir}/#{base}.hs"

        puts "Decrypting #{file} => #{fileOut} with password #{pass}..."
        if File.exists?(fileOut) then
            puts "File '#{fileOut}' already exists. Overwrite? (yes/no)"
            answer = STDIN.gets.strip

            break unless answer == "yes"
        end

        contents = File.read(file)
        decrypted = contents.decrypt(
            :symmetric,
            :algorithm => 'des-ecb',
            :password => pass
        )

        File.open(fileOut, 'w') do |f|
            f.write(decrypted)
        end
    end
end

task :runhs, [:problem] do |t, args|
    problem = args[:problem]
    dir   = "#{problem}.hs"
    files = FileList.new("#{dir}/*.hs")

    FileUtils.mkdir_p('build')
    FileUtils.mkdir_p("build/#{problem}")

    exe = "build/#{problem}/#{problem}"

    objs = []
    files.each do |file|
        base = File.basename(file, ".hs")

        obj = "build/#{problem}/#{base}.o"
        objs.push(obj)

        puts "Making #{obj}..."
        `ghc -c -o #{obj} #{file}`
    end

    puts "Making #{exe}.."
    `ghc -o #{exe} #{objs.join(" ")}`

    puts "Running #{exe}"
    puts "--------------------------------------------------------------------------------"
    puts ""

    res = ""
    if File.exists?(exe) then
        res = `#{exe}`
    elsif File.exists?("#{exe}.exe")
        res = `#{exe}.exe`
    else
        puts "Couldn't find executable: #{exe}"
        exit(1)
    end

    puts res
end
