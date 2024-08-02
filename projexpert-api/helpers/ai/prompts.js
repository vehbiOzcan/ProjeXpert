const PID = `
Konu: Proje Başlatma Belgesi Oluşturma
Açıklama: Bu prompt, aşağıda verilen belge oluşturulurken kullanılacak olan toplantı transkripti veya verilen yönergeler temel alınarak bir Proje Başlatma Belgesi oluşturmanızı isteyecektir. Proje Başlatma Belgesi, projenin genel bir özetini, hedeflerini, teslim edilecekleri, kapsamı ve dışındaki konuları, faydaları ve maliyetleri, ek olarak ilgili tüm ek bilgileri içermelidir. Çıktı, aşağıda belirtilen başlıkları takip ederek Markdown formatında oluşturulmalıdır.
Belgede olması gereken başlıklar {
Proje Özeti
[Toplantı transkriptinden veya yönergelerden alınan proje özeti buraya gelecek]
Proje Hedefleri
[Belirli, ölçülebilir, ulaşılabilir, ilgili ve zamanında (SMART) hedefler buraya eklenecek]
Teslim Edilecekler
[Projenin sonunda elde edilecek somut çıktılar buraya gelecek]
Kapsam ve Hariç Tutulanlar
Kapsam
[Projenin kapsamına giren tüm alanlar buraya eklenecek]
Hariç Tutulanlar
[Proje kapsamına dahil edilmeyen alanlar buraya gelecek]
Faydalar ve Maliyetler
Faydalar
[Projenin sağlayacağı tüm faydalar buraya eklenecek]
Maliyetler
[Projenin tahmini maliyetleri buraya eklenecek]
Ek
[Toplantıdaki anlaşmazlıklar, önemli notlar ve ek bilgiler buraya eklenecek] }
Belge oluşturulurken kullanılacak toplantı transkripti:
`
const OKR = `
Konu: OKR Oluşturma
Açıklama: Bu prompt, verilen toplantı transkripti veya yönergelere dayanarak bir OKR (Objectives and Key Results) seti oluşturmanızı isteyecektir. OKR, bir hedef (Objective) ve bu hedefe ulaşmak için belirlenen temel sonuçlardan (Key Results) oluşur. Çıktı, aşağıda belirtilen başlıkları takip ederek Markdown formatında oluşturulmalıdır.

Örnek Belge Formatı

Hedefler
Hedef 1: [Toplantı transkriptinden veya yönergelere dayanan ilk hedef]
Temel Sonuçlar:
[Hedefe ulaşmanın ölçülebilir ilk sonucu]
[Hedefe ulaşmanın ölçülebilir ikinci sonucu]
 ...
[Hedefe ulaşmanın ölçülebilir n. sonucu]

Hedef N: [Toplantı transkriptinden veya yönergelere dayanan N. hedef]

Notlar
OKR'ler iddialı ancak ulaşılabilir olmalıdır.
Her hedef, net ve motive edici olmalıdır.
Temel sonuçlar, hedefin başarısını ölçmek için somut ve spesifik olmalıdır.

Belge oluşturulurken kullanılacak toplantı veya istek transkripti:
`

const SPRINT = `
Konu: Sprint Planı Oluşturma
Açıklama: Bu prompt, verilen toplantı transkripti veya yönergelere dayanarak bir Sprint Planı oluşturmanızı isteyecektir. Sprint Planı, belirli bir süre (genellikle 1-4 hafta) boyunca bir takımın gerçekleştireceği görevleri ve bu görevlerin hedeflerini tanımlar. Çıktı, aşağıda belirtilen başlıkları takip ederek Markdown formatında oluşturulmalıdır.

Örnek Belge Formatı:
Sprint Özeti
Sprint Adı: [Sprint adı]
Sprint Tarihleri: [Sprint'in başlangıç ve bitiş tarihleri]
Amaç: [Sprint'in amacı veya genel hedefi]
Kullanıcı Hikayeleri ve Görevler
Kullanıcı Hikayesi 1: [İlk kullanıcı hikayesi]

Görevler:
[İlk görev]
[İkinci görev]
[n. görev]

Kullanıcı Hikayesi 2: [İkinci kullanıcı hikayesi]

Görevler:
[İlk görev]
[İkinci görev]
[n. görev]

Kullanıcı Hikayesi N: [N.kullanıcı hikayesi]

Görevler:
[İlk görev]
[İkinci görev]
[n. görev]

Tamamlanma Kriterleri
[Her bir kullanıcı hikayesinin veya görevin tamamlandığını belirleyen kriterler]
Riskler ve Bağımlılıklar
[Sprint sırasında karşılaşılabilecek potansiyel riskler ve bunların çözüm yolları]
[Diğer takımlara veya çalışmalara olan bağımlılıklar]

Notlar
Sprint hedefleri, kullanıcı ihtiyaçlarını karşılamaya odaklanmalıdır.
Görevler, belirli, ölçülebilir ve zamanında tamamlanabilir olmalıdır.
Sprint sonunda, belirlenen tamamlanma kriterleri gözden geçirilmeli ve değerlendirilmeli.

Belge oluşturulurken kullanılacak toplantı veya istek transkripti:
`

const  Transkript = `
Aşağıdaki kişilerin bulunduğu, Sauce & Spoon’un ilk proje toplantısının dökümünü aşağıda 
bulabilirsiniz:  
• Pınar (Proje Yöneticisi) 
• Deniz (Operasyon Müdürü) 
• Gizem (Genel Müdür, Kuzey) 
• Ali (Genel Müdür, Şehir Merkezi) 
• Serdar (Restoran Danışmanı) 
Pınar (Proje Yöneticisi): Herkese merhaba. Toplantıya katıldığınız için teşekkür ederim. 
Başlamak ve bu projeyle nelere ulaşmayı beklediğinizi öğrenmek için sabırsızlanıyorum. Mevcut 
proje belgelerini gözden geçirdim, proje başlatma belgesini de hazırlamaya başladım. Başlatma 
belgesi tamamlanıp tüm paydaşlardan onay alınca planlama aşamasına geçebileceğiz. Bu 
toplantıyı bu zamana kadar edindiğim bilgileri gözden geçirmek ve başarılı bir başlangıç 
yapabilmek için yapmak istedim.  
Deniz (Operasyon Müdürü): Sauce & Spoon ekibine hoş geldin Pınar. İyi ki bizimlesin. Sana 
nasıl yardımcı olabiliriz? 
Pınar: Teşekkürler Deniz. Bu projenin işletme teklifi üzerine çalıştığın için herkese proje fikriyle 
ilgili genel bir fikir vererek başlamak ister misin?  
Deniz: Tabii ki. Sauce & Spoon restoranımızın iki şubesinde masalara konacak menü tabletlerine 
geçişle ilgili bir pilot uygulama başlatmak istiyor. Bu şubelerimiz de Sauce & Spoon Kuzey ve 
Sauce & Spoon Şehir Merkezi. Bu projeyle konuklarımız bir garsonun kendileriyle ilgilenmesini 
beklemek yerine restorana geldikleri an tabletler üzerinden siparişlerini verebilecek. Bu bekleme 
meselesi geçmişte sorun olmuştu. Bu iki şubenin pilot uygulama için uygun olduğunu 
düşünüyorum çünkü ikisi de bu yeni konsepti deneyebilecek uygun sayıda personele ve konuk 
hacmine sahip. Gizem ve Ali bu şubelerin genel müdürleri. Sizin eklemek istediğiniz bir şey var 
mı? 
Gizem (Genel Müdür, Kuzey): Evet. Pilot uygulama için şubemizin seçilmesi beni çok 
heyecanlandırıyor. Bu tablete geçiş projesini restoranın hangi kısmında kullanmak istiyoruz? 
Yoksa bu uygulama tüm restorana mı uygulanacak? Benim şahsi fikrim en uygun kısmın bar 
kısmı olduğu yönünde. Bar kısmındaki masa devir süresinin hep daha hızlı olmasını isteriz. 
Ayrıca bar kısmındaki konukların yemek deneyimlerinin hızlanmasından memnun kalacağını 
düşünüyorum. 
Ali (Genel Müdür, Şehir Merkezi): Gizem’e katılıyorum. Ben de tabletlerin bar kısmında test 
edilmesini tercih ederim.  
Deniz: Çok iyi noktalara parmak bastınız. Evet, tabletlerle yapılacak pilot uygulama için restoranın 
yalnızca bir kısmını seçmeyi düşünmüştük. Bar kısmında uygulamak makul görünüyor. 
Pınar: Tamam, müthiş. Tabletleri her restoranın bar kısmında uygulayacağız. Deniz, bu projede 
ulaşmayı istediğiniz önemli sonuçlardan bahsedebilir misin? 
Deniz: Şirket genelindeki en büyük hedeflerimizden biri ürün çeşitliliğimizi artırmak. Bu projenin 
bize getirilerinden birinin de meze satışlarındaki artış ve bazı başlangıç yemeklerinin öne çıkması 
olacağını düşünüyoruz. Serdar, bazı tablet tedarikçilerinin web sitelerinde belli unsurları öne 
çıkaran bir özellik olduğunu görmüştüm. Bu gayet standart ve bizim de projeye dahil 
edebileceğimiz bir şey gibi görünüyor. 
Serdar (Restoran Danışmanı): Evet. Bazı modellerde menüdeki herhangi bir öğeyi eklenti olarak 
öne çıkarabiliyor ve aynı zamanda bu öğe için indirim kuponu koyabiliyorsunuz. 
Deniz: Mükemmel. Pınar, menü öğesi eklentisini ve indirim kuponunu denemeyi çok isteriz. Bu 
yüzden de hangi tablet paketinde bu özelliklerin olduğunu öğrenmemiz gerekecek. Bir de 
ortalama masa devir süremizi 30 dakika kadar azaltmak istiyoruz çünkü müşterinin canını çok 
sıkan şeylerden biri de hizmetteki gecikmeler. Bunun iddialı bir hedef olduğunun farkındayım ama 
başarabileceğimize inancım tam çünkü konuklar anında sipariş vermek için tabletleri 
kullanabilecek ve garsonu beklemeden kendi hesaplarını ödeyebilecekler.   
Pınar: Anladım. Restoran sektöründe yeni olduğum için bazı ifadelerin tanımlarıyla ilgili biraz 
yardımınıza ihtiyacım var. Masa devir süresi derken ne kastettiğinizi açıklayabilir misin? 
Deniz: Elbette. Masa devir süresi bir müşteri grubunun masayı işgal ettiği süreye deniyor. Bu 
süreye masanın bir sonraki konuk için hazırlandığı süre de dahil oluyor. Şu an bu şubelerdeki 
ortalama devir süremiz restoranın çoğu kısmı için yaklaşık 95 dakikayken bar için de 80 dakika.  
Pınar: Teşekkür ederim. Bu durumda ortalama masa devir sürelerini 30 dakika azaltmanın makul 
bir hedef olduğunu düşünüyorsunuz. 
Gizem: Evet. Yemek saatlerimiz akşam 5 ile 10 arasında. Bu saatler arasında her masanın en az 
dört misafir grubuna hizmet verebileceğini düşünüyoruz. Konuklarımızın harika bir deneyim 
yaşamalarını istiyoruz. Bu yüzden acele etmelerini de istemeyiz. Ama tabletler sayesinde 
masaları ve garsonları beklerken harcadıkları süreyi azaltabileceğimizi düşünüyoruz. Masa devir 
süresini azaltmanın günlük ortalama konuk sayımızı %10 artırmak gibi başka hedeflerimize de 
yardımcı olmasını bekliyoruz. 
Pınar: Anlıyorum. Konuyla ilgili daha fazla bilgi verdiğiniz için teşekkür ederim. Konuşmak 
istediğiniz başka hedefler var mı? 
Ali: Benim şubemde yemek israfının giderek arttığını fark ettik. Bunun bir sebebinin de müşteriler 
yemeği geri gönderdiğinde tabaklarını ikram etmemiz olduğunu düşünüyorum.  
Pınar: İkram derken? 
Ali: İkram derken ücret almamayı kastediyorum. Mevcut politikamıza göre konuklarımız 
siparişlerinin doğru hazırlanmadığını bildiriyorsa onlara yeni tabaklar hazırlıyoruz. Sorun da şu, 
bu çok sık olursa büyük külfet yaratabiliyor ve maliyetli olabiliyor. 
Gizem: Bu bizim de karşılaştığımız bir sorun. Acaba tabletler konukların özel taleplerini mutfağa 
daha doğrudan ulaştırmamıza yardımcı olabilecek mi? Bu şekilde konuk menüdeki bir öğede 
herhangi bir değişiklik yaparsa elimizde bunun kaydı olacak. 
Pınar: Anladım. Yemek israfını azaltmaya yönelik belirli bir hedefiniz var mı? 
Ali: Pek sayılmaz. Ancak bu projeyle israfı ne kadar azaltabileceğimize dair tahminler elde edip 
oradan makul bir hedef belirleyebilirsek harika olacak. 
Pınar: Tamam, bu konuyla ilgili ne yapabilirim, bir bakayım. O halde başlatma belgesine pilot 
uygulamayı barda yapacağımızı, menü eklentileri ve indirim kuponları olan tablet paketlerini 
gözden geçireceğimizi ve yiyecek israfını azaltma hedefiyle ilgili tahminlere ulaşacağımızı 
ekliyorum. O zaman şimdi de tablete geçiş projesiyle ilgili endişelendiğiniz bir şey var mı, sizden 
onu duymak isterim. 
Gizem: Değişim bazen personel açısından zorlayıcı olabilir. Yeni bir teknoloji benimseniyorsa hep 
bir öğrenme eğrisi oluşur ve insanlar bazen direnç gösterebilirler. 
Pınar: Evet, elbette. Projeye, personele yeni sistemle ilgili nasıl eğitim vereceğimize dair bir plan 
da ekleyeceğiz. Başka bir konu var mı? 
Deniz: Tabletlerin mevcut POS sistemimiz ve ana bilgisayar yazılımımızla nasıl entegre olacağı 
da tam olarak belli değil. 
Pınar: Affedersiniz, bu iki yazılımın işlevi hakkında daha fazla bilgi verebilir misiniz? 
Deniz: Ana bilgisayar yazılımı masa kullanımını ve bekleme listesini takip ederken POS yazılımı 
ücretleri yönetir, siparişleri takip eder ve yemeğin sonunda hesabı çıkarır. Tablet yazılımı mevcut 
sistemlerimizle uyumlu olmalı ve entegrasyonu mümkün olduğunca sorunsuz halletmek için bu 
sistemleri doğru şekilde yapılandırmalıyız. Serdar: Çalıştığım hesap hizmetleri ekiplerinin bu 
konuda çok tecrübesi var. Pınar, tablet paketlerini araştırmaya hazır olduğunuzda bana haber 
ver, bu konuyla ilgili birlikte çalışalım. 
Pınar: Sağ ol Serdar. Bizim için çok faydalı olur.  
Deniz: Mükemmel. Pınar, başka sorun var mı? 
Pınar: Bir bakayım. Bu geçiş projesinin takvimini gözden geçirmek istiyordum. 
Deniz: Pilot uygulamaya ikinci çeyreğin başında başlamak istiyoruz böylece önümüzdeki çeyrekte 
her şeyin hazır olmasını sağlayabiliriz. Bu işi ne kadar erken yaparsak o kadar iyi çünkü genelde 
ocak ve şubat aylarında yoğunluğumuz daha az oluyor. 
Pınar: Çok iyi. Hepinize sorularıma cevap verdiğiniz için teşekkür ederim. Daha sonra başka 
sorularım da olabilir ama şimdilik bu kadar. Projeyi özetleyen, hedefleri, kapsamı ve ileride gerekli 
olabilecek teslimatları açıklayan bir proje başlatma belgesi hazırlamaya başlayacağım.
`

export const AIPrompts = {PID, OKR, SPRINT ,Transkript}; 