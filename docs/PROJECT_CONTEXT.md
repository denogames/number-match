# Number Match — Project Context

Bu belge kalıcı proje bağlamı ve belge giriş noktasıdır. İlk baseline 18 Ekim 2026 tarihinde `master` üzerindeki `83a22da902c3db1f5c31a63b873917f3de99a132` kaynaklarından oluşturuldu. Güncel görev ve gözlem için [PROJECT_STATUS](PROJECT_STATUS.md) okunmalıdır. Kod varlığı çalışırlık veya kullanıcı kabulü değildir.

## Kanonik kayıtlar

| Bilgi | Tek kanonik yer | Sorumluluk |
| --- | --- | --- |
| Bağlam, belge giriş noktası, bileşen ve rol haritası | Bu belge | Kaynaklı, görece kalıcı proje bilgisi |
| Güncel durum, aktif işler, bulgular ve son checkpoint | [PROJECT_STATUS](PROJECT_STATUS.md) | Teknik çalışma sonunda güncelleme |
| Kararlar ve gerekçeleri | [DECISIONS](DECISIONS.md) | Karar sahibi/durum/kaynak ayrımı |
| Roadmap ve milestone planlaması | [POST_MVP_ROADMAP](POST_MVP_ROADMAP.md) | Mevcut planın tek yeri; kullanıcı onayı bilinmiyor |
| Mühendislik davranışları | [AGENTS](../AGENTS.md) | Kısa kalıcı talimatlar |
| Oyun kuralları / mimari / monetizasyon niyeti | [GAME_RULES](GAME_RULES.md), [ARCHITECTURE](ARCHITECTURE.md), [MONETIZATION_SETUP](MONETIZATION_SETUP.md) | Konuya özel teknik ayrıntı |

Durum belgesindeki M0 görev takibi ve Proposed M1 devri ikinci roadmap değildir. Gelecekte milestone planına alınacak işler roadmap'te uzlaştırılmalıdır; M0 görevi mevcut roadmap'i değiştirmez. README genel tanıtım ve komut kaynağıdır; güncel doğrulama sonucu için durum kaydı esas alınır. ChatGPT kaynak kopyaları commit/tarihle işaretlenen aktarımlardır; bağımsız ikinci yazılabilir otorite değildir. Orada verilen kararlar kaynakları korunarak repository kayıtlarına taşınır.

## Ürün ve kapsam

**Belge niyeti:** Number Match, dokuz sütunlu dinamik tahtada sayı çiftlerini eşleştirerek tahtayı temizlemeye dayalı mobil mantık oyunu ([README](../README.md), [GAME_RULES](GAME_RULES.md), Overview ve bölümler 1–5).

**Statik kod gözlemi:** Classic, Daily ve Timed modları; hücre seçimi/eşleşme, skor/combo, satır temizleme, sayı ekleme, undo, ipucu, yerel kayıt ve coin koordinasyonu için kod mevcut. Kaynaklar: [NumberMatchEngine](../lib/domain/engine/number_match_engine.dart), [GameController](../lib/application/game/game_controller.dart), [RewardService](../lib/application/economy/reward_service.dart). Bu akışlar M0'da çalıştırılmadı.

**Çıkarım:** Mantık bulmacası oyuncuları olası hedef kullanıcıdır. Onaylanmış persona, yaş aralığı, pazar, iş hedefi veya başarı metriği bilinmiyor. Geçmiş ürün kararları, kabul ve yayın durumu kaynaklardan çıkarılmadı.

### Belgelenen oyun ve ekonomi sözleşmesi

- Aynı değer veya toplam 10; kendisiyle/temizlenmiş hücreyle eşleşme yok.
- Arası temiz okuma sırası ardışıklığı (satır aşabilir) veya yatay/dikey/45 derece çapraz hat.
- Add Numbers aktif sayıları sırasıyla sona kopyalar, combo'yu 1'e döndürür. Belgede Classic için temiz satırların daraltılması anlatılır.
- Aynı sayı: 10 × combo; toplam 10: 15 × combo; satır: 50 puan; tahta: 1000 bonus puan. Combo üst sınırı 10; geçersiz eşleşmede 1.
- Her 5 eşleşme 5 coin; satır 10 coin; Classic/Timed zaferi 75, Daily 150 coin; ipucu 50 coin.
- Undo tahta, skor, combo ve eşleşme sayaçlarını geri getirir.

Bunlar [GAME_RULES](GAME_RULES.md) niyetinin özetidir. Uç durumlar ve belge/kod farkları [durum kaydında](PROJECT_STATUS.md) izlenir.

## Mimari ve teknoloji

[pubspec.yaml](../pubspec.yaml): `number_match`, sürüm `1.0.0+1`, Dart SDK kısıtı `^3.13.4`; Flutter, `flutter_riverpod ^3.4.3`, `go_router ^18.0.2`, `drift ^2.35.2`, `shared_preferences ^2.5.6`, `in_app_purchase ^3.3.1`. Bunlar manifest kısıtlarıdır; kurulu veya güncel en son SDK sürümü değildir. README'nin Flutter 3.47+/Dart 3.13+ beyanı ortamda doğrulanmadı.

| Bileşen | Yol / örnek kaynak | Sorumluluk |
| --- | --- | --- |
| Domain | [motor](../lib/domain/engine/number_match_engine.dart), [PairValidator](../lib/domain/engine/pair_validator.dart), [GameState](../lib/domain/models/game_state.dart) | Kurallar, modeller, tahta/ipuçları, repository arayüzleri |
| Application | [providers](../lib/application/providers.dart), [controller](../lib/application/game/game_controller.dart) | Riverpod durum ve servis koordinasyonu |
| Data | [AppDatabase](../lib/data/local/database/app_database.dart), [GameRepositoryImpl](../lib/data/repositories/game_repository_impl.dart), [AppPreferences](../lib/data/local/preferences/app_preferences.dart) | SQLite ve tercihler |
| Presentation | [GameScreen](../lib/presentation/screens/game/game_screen.dart) | Ekranlar ve widget'lar |
| Core | [router](../lib/core/router/app_router.dart), [temalar](../lib/core/theme/app_themes.dart) | Yönlendirme, tema, sabitler, ses/haptik |

Mimari niyet [ARCHITECTURE](ARCHITECTURE.md) içindedir. Kaynak klasörleri korunur; M0 yeniden tasarım veya kaynak taşıma işi değildir.

### Kullanıcı akışı ve veri

[main](../lib/main.dart) tercihler/veritabanını oluşturur. [SplashScreen](../lib/presentation/screens/splash/splash_screen.dart) servisleri başlatır, tutorial tamamlanmasına göre tutorial/home'a gider. [Router](../lib/core/router/app_router.dart) oyun, daily, istatistik, mağaza ve ayarlar rotalarını içerir. Dört tema: Classic Paper, Midnight, Ocean, High Contrast. Tema/erişilebilirlik niyeti cihaz veya standart uyumluluğu doğrulaması değildir.

[AppDatabase](../lib/data/local/database/app_database.dart) şema sürümü 1; native SQLite bağlantısı. [Tablolar](../lib/data/local/database/tables.dart): `GameSessionsTable`, `DailyChallengesTable`, `GameStatisticsTable`, `PlayerWalletsTable`, `EntitlementsTable`. Ayarlar SharedPreferences'ta. Repository içinde mevcut bulut kayıt veya üretim backend kurulumu kanıtlanmadı; web klasörü platform desteği kanıtı sayılmamalı.

### Monetizasyon niyeti ve sınırı

[MONETIZATION_SETUP](MONETIZATION_SETUP.md), bölümler 1–3: kalıcı non-consumable Ads Free `com.numbermatch.game.ads_free`; belgede 2.99 USD; doğal molada en az 120 saniye aralıklı interstitial; isteğe bağlı 100 coin rewarded; Ads Free sahiplerine reklamsız rewarded ödülü. Fiyat güncel mağaza verisi değildir. Belgede gerçek reklam adaptörü, platform ayarı, backend doğrulaması ve mağaza kurulumu gereken işler anlatılır. Kodda mock reklam ve doğrulayıcı taslakları vardır; canlı kurulum sonucu çıkarılamaz.

## Geliştirme, test ve yayın kaynakları

[README](../README.md), Testing ve Building bölümleri test/analyzer, Drift üretimi ve Android/iOS build yönergelerini içerir; [analysis_options](../analysis_options.yaml) lint tanımıdır. Bu komutların bulunması çalıştırılmış başarı değildir. M0 test/analyzer/build/kurulum yetkisi içermez.

[Motor](../test/engine/number_match_engine_test.dart), [eşleşme](../test/engine/pair_validator_test.dart), [üretim](../test/engine/board_generator_test.dart), [kalıcılık](../test/persistence/persistence_test.dart), [monetizasyon](../test/monetization/monetization_test.dart), [widget](../test/widgets/game_widgets_test.dart) ve [home smoke](../test/widget_test.dart) test tanımları mevcut. Güncel kanıt/sınırlar durum kaydındadır. İncelenen izlenen kaynaklarda CI workflow/release günlüğü bulunmadı; dış CI ve mağaza durumları bilinmiyor. `c241d06` ve `83a22da` commit mesajları kabul/yayın kanıtı değildir.

## Roller ve ortamlar

| Rol / sohbet adı | Sorumluluk | Kullanım |
| --- | --- | --- |
| ChatGPT `00 — HQ \| Project Director` | Yön, öncelik, karar ve milestone koordinasyonu | Kullanıcının verdiği hedef; içeriği/varlığı bu görevde okunmadı |
| Codex Engineering HQ; önerilen ad `00 — Engineering HQ \| Technical Lead` | Teknik inceleme, uygulama, review ve doğrulama | Mevcut görev rolü; yeni sohbet oluşturulmadı |
| Recovery | İlk analiz kaynağı, sonradan bulunan bağlamı uzlaştırma | Kullanıcının M0 metninde aktardığı tarihsel referans; sohbet içeriğine doğrudan erişilmedi |
| Kullanıcı | Ürün kararları, kapsam ve kabul | AI önerilerini kabul edilmiş sayma |

Önceki M0 belgesinde Recovery sohbeti için `Proje kurtarma ve onboarding`, yerel proje için `Number Match - PMO`, ChatGPT projesi önerisi için `Number Match — Project Management` adları aktarılmıştı. Bu devam oturumunda bu adların kaynağı veya uygulamadaki güncel karşılığı doğrulanmadı; kurulmuş proje/sohbet bilgisi ya da kullanıcı kararı sayılmaz. Uygun mevcut alan/sohbet tercih edilir; uzman sohbetler somut ihtiyaçta önerilir.

ChatGPT/Codex projesi uygulama gruplamasıdır; fiziksel klasör, Git repository, checkout/worktree, sohbet ve bulut ortamı ayrı kavramlardır. Otomatik dosya veya geçmiş eşitlemesi ve aynı yolların aynı dosya alanını gösterdiği varsayılmaz. Makineye özgü erişim bilgisi oturum devrinde tutulur. Sonuç HQ'ya tek parça, gerekli bağlamı içinde taşıyan handoff ile döner.
