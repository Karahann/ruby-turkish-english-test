puts "*******************"
puts "1-) Ingilizce test
2-) Turkce test"
puts "-------------------------------------------"
print "Cozeceginiz test turu(basindaki rakam): "
secim = gets.chomp.to_i
puts "-------------------------------------------"

metin = File.read("kelimeler.txt").split("\n")

sozluk = {}
cevaplar = []
soru = []
yanlis = []
yanlislar = []
m = 0
puan = 0

if secim == 1

  metin.each do |kelimeler|
    sozluk.merge!(kelimeler.split(" : ")[0] => kelimeler.split(" : ")[1])
  end

elsif secim == 2

  metin.each do |kelimeler|
    sozluk.merge!(kelimeler.split(" : ")[1] => kelimeler.split(" : ")[0])
  end

else
  puts "1 veya 2 giriniz."
  exit
end

dizi = sozluk.keys.shuffle.join(",").split(",")            #anlami iki kelime olanlar icin "," ile birlestirip "," ile bolduk

4.times do 
  soru<<dizi[m]
  m += 1
end

dizi.each do |kelime|
  cevaplar<< sozluk[kelime]
end

soru.each.with_index do |sorular,i|

  cevap = cevaplar.delete(sozluk[dizi[i]])
  cevaplar.shuffle!
  siklar = [cevaplar[0], cevaplar[1], cevaplar[2], cevap].shuffle!

  puts ""
  puts "Soru#{i+1}.'#{sorular}' kelimesinin karsiligi nedir?
  A) #{siklar[0]}
  B) #{siklar[1]}
  C) #{siklar[2]}
  D) #{siklar[3]}"
  print "Cevabiniz: "
  girdi = gets.chomp.upcase

  puanlama ={"A"=>siklar[0], "B"=>siklar[1], "C"=>siklar[2], "D"=>siklar[3]}

  if puanlama.include?(girdi)

    if puanlama["#{girdi}"] == cevap
      puan += 25
    else
      yanlislar<<cevap
      yanlis<<(i+1)
    end

  else
    puts ""
    puts "a,b,c veya d siklarindan birini giriniz."
    print "Cevabiniz: "
    girdi = gets.chomp.upcase

    if puanlama.include?(girdi)

      if puanlama["#{girdi}"] == cevap
        puan += 25
      else
        yanlislar<<cevap
        yanlis<<(i+1)
      end

    else
      puts ""
      puts "iki kere hatali giris yaptiniz programi tekrar calistiriniz."
      exit
    end
    
  end

end
puts ""
puts "Sonuc: #{puan} puan aldiniz"

if yanlis.size > 0
  puts ""
  puts "Yanlis yapilan sorular: #{yanlis.join(",")}"
  puts "Yanlis sorularin cevaplari:"
  yanlis.each.with_index do |numarasi, x|
    puts "#{numarasi}.sorunun cevabi #{yanlislar[x]} olmali"
  end

else
  puts "Butun sorulari bildiniz."
end