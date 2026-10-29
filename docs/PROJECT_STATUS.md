# Number Match — Güncel Durum ve Devam Kaydı

## Gözlem ve aktif görev

- Tarih: **18 Ekim 2026** (kullanıcı saat dilimi Europe/Istanbul).
- Repository: Number Match uygulama repository'si; yerel Git kökü çalışma klasörüyle eşleşti. Makineye özgü mutlak yol oturum handoff'unda tutulur.
- Branch/HEAD: `master @ 83a22da902c3db1f5c31a63b873917f3de99a132`.
- Aktarılan Recovery başlangıcı/sonu: temiz çalışma alanı, tek worktree; `origin/master` takip ilişkisi. Recovery'de özel AGENTS bulunmadığı bildirilmiş. Bunlar geçmiş gözlemlerdir.
- Bu devam oturumunun başlangıcı: README değişmiş; AGENTS, PROJECT_CONTEXT, PROJECT_STATUS ve DECISIONS izlenmeyen dosyalar olarak zaten mevcut. Önceki durum kaydının temiz başlangıç ve belgeleri oluşturma beyanı tarihsel kayıttır; bu oturumda yeniden gözlenmiş sayılmaz. Mevcut değişiklikler korundu ve belgeler yeniden oluşturulmadan uzlaştırıldı.
- Güncel yerel kontrolde tek worktree ve `origin/master` takip ilişkisi görüldü. Fetch/ağ kontrolü yok; uzak güncellik bilinmiyor. Gerçek uygulama checkout'u incelendi; ChatGPT aynasında alternatif kayıt üretilmedi.
- Aktif görev: **M0 — Kalıcı proje bağlamı ve çalışma düzeni**. Belgeler **Implemented**; belge kontrolleri aşağıda; kullanıcı kabulü **bekleniyor**. Ürün çalışırlığı veya yayın sonucu değildir.
- Görev kaynağı/yetkisi: [D-001](DECISIONS.md); kullanıcının bu oturumda eklediği M0 görev metni. Yalnız dört proje belgesi ve README giriş bağlantısı; mevcut roadmap/diğer belgeler/kod korunur. Test/analyzer/build/uygulama/kurulum/migration, commit/push/yayın yok.

## Kanıt ve durum sözlüğü

**Belge niyeti** kaynakta anlatılan hedeftir. **Güncel statik kod gözlemi** okunarak görülen uygulamadır. **Test beklentisi** testte tanımlı iddiadır. **Yürütülmüş doğrulama** gerçekten çalıştırılan kontrol ve sonucudur. **Çıkarım** bunlardan türetilen, kanıtı sınırlı yorumdur. **Kullanıcı kararı** sahibi/kaynağı bilinen açık karardır.

**Proposed:** AI önerisi. **Implemented:** uygulanmış değişiklik. **Verified:** belirtilen ortam/kapsamda kanıtla kontrol edilmiş. **Accepted:** kullanıcı/yetkili kabul etmiş. **Released:** hedefe yayın ve kanıt mevcut. M0 belge kontrolleri ürünün Verified/Accepted/Released olduğu anlamına gelmez.

## Recovery ile güncel karşılaştırma

Aktarılan Recovery ile güncel HEAD/branch/tek worktree/takip ilişkisi aynı. Fark: bu devam oturumu temiz başlamadı; M0'un beş belge değişikliği başlangıçta zaten vardı. Belgelerdeki önceki tamamlanma beyanı kullanıcı kabulü sayılmadı. R1–R10 kaynakları yeniden okundu; giderilmiş bulgu gözlenmedi. Kod veya dependency değişikliği yok. R6 için mevcut kayıttaki ek ayrıntı da kaynakla karşılaştırıldı: GameConstants içinde 120 saniye ve +3/+10 saniye bonus sabitleri var; controller motoru süre geçirmeden çağırıyor. Bu ayrıntı çözüm veya ürün kararı değildir. Bu devam oturumunun değişikliği durum/checkpoint, karar kaynağı ve aktarılmış sohbet bilgisinin kanıt sınırını açıklığa kavuşturmaktır.

## Açık bulgular

Tüm maddeler 18 Ekim 2026 statik gözlemine dayanır; yürütülmüş teknik doğrulama/düzeltme yoktur.

| Kimlik | Güncel kaynak ve gözlem | Etki / sonraki doğrulama |
| --- | --- | --- |
| R1 | [IapService](../lib/application/monetization/iap/iap_service.dart), kurucu: `_settingsRepository`/`_analyticsService`; [providers](../lib/application/providers.dart), `iapServiceProvider`: `settingsRepository`/`analyticsService` çağrısı | Olası derleme engeli; analyzer sonucu yok. Önce yetkili M1 doğrulaması |
| R2 | [purchase_verifier](../lib/application/monetization/iap/purchase_verifier.dart), `ProductionServerPurchaseVerifier.verify`: URL boşsa hata, aksi halde ağ isteksiz başarı/sentetik imza. Sandbox yalnız productId/payload boşluğunu denetler; IapService varsayılanı sandbox | Canlı mağaza/kriptografik doğrulama kanıtı yok; boş olmayan URL güvenlik doğrulaması sayılmaz |
| R3 | [providers](../lib/application/providers.dart), `adProviderProvider`: `MockAdProvider` | Gerçek reklam adaptörü/yayını doğrulanmadı |
| R4 | [Android Gradle](../android/app/build.gradle.kts), `buildTypes.release`: debug signing | Üretim release imzası hazırlanmış sayılmaz; build çalıştırılmadı |
| R5 | [Monetizasyon](MONETIZATION_SETUP.md), 2.3: `com.numbermatch.game`; [Android](../android/app/build.gradle.kts): `com.numbermatch.game.number_match`; [iOS proje](../ios/Runner.xcodeproj/project.pbxproj), `PRODUCT_BUNDLE_IDENTIFIER`: `com.numbermatch.game.numberMatch` | Belge/platform kimliği farkı; mağaza kayıtları bilinmeden doğru kimlik seçilmez. D-003 |
| R6 | [README](../README.md), Game Modes: 120 saniye ve zaman bonusu; [GameConstants](../lib/core/constants/game_constants.dart): 120 ve +3/+10 bonus sabitleri; [motor](../lib/domain/engine/number_match_engine.dart), `initTimedGame`: 180; [controller](../lib/application/game/game_controller.dart) süre argümansız çağırır. İncelenen eşleşme/timer akışında bonus uygulanması görülmedi | Sözleşme çelişkisi; D-004. Sabit varlığı çalışan bonus kanıtı değil |
| R7 | [controller](../lib/application/game/game_controller.dart), `loadOrCreateGame`: kaydı tarih karşılaştırmadan yükler; `_handleGameCompletion`: DateTime.now ile günlük anahtar. [repository](../lib/data/repositories/game_repository_impl.dart): `${mode.storageKey}_active` anahtarı | Gece yarısı/devam/tamamlama davranışı test edilmeli; D-005 |
| R8 | [GameScreen](../lib/presentation/screens/game/game_screen.dart), `_showPauseDialog`, home dönüşleri ve dispose: controller timer durdurma çağrısı görülmedi; [controller](../lib/application/game/game_controller.dart) periyodik timer içerir | Pause/arka plan/menü sözleşmesi ve cihaz doğrulaması gerekli; D-006 |
| R9 | [controller](../lib/application/game/game_controller.dart), `requestHint`: ipucu aranmadan `spendForHint`; [motor](../lib/domain/engine/number_match_engine.dart), `undo`: oyun sayaçları geri; [RewardService](../lib/application/economy/reward_service.dart): coin ödülleri ayrı yönetilir | Boş ipucunda ücret ve undo/yeniden eşleşmede ödül tutarlılığı riski; henüz yeniden üretilmedi; D-007 |
| R10 | [analytics](../lib/application/analytics/analytics_service.dart), `ConsoleAnalyticsBackend.sendEvent`: boş; [DB](../lib/data/local/database/app_database.dart): dart:io/native; [README](../README.md): production/accessibility beyanları | Üretim analytics, web desteği, production-ready ve erişilebilirlik uyumu doğrulanmadı |

## Doğrulama matrisi

| Alan | Kanıt türü / kaynak | Gerçekte yapılan ve sınır |
| --- | --- | --- |
| Repository erişimi | Yürütülmüş yerel kontrol: Git root/status/HEAD/worktree/takip ilişkisi | Yukarıdaki checkout ve başlangıçtaki beş belge değişikliği görüldü; tek worktree, fetch yok |
| Kaynak incelemesi | Belge niyeti ve statik kod gözlemi; yukarıdaki bağlantılar | Manifest, mevcut docs, giriş/router/splash, controller/motor, veri ve monetizasyon kaynakları okundu |
| Motor kuralları | Test beklentisi: [pair_validator](../test/engine/pair_validator_test.dart), [engine](../test/engine/number_match_engine_test.dart), [board_generator](../test/engine/board_generator_test.dart) | Eşleşme, skor/combo, undo/add/hint ve tarih deterministikliği tanımlı; çalıştırılmadı |
| Kalıcılık | Test beklentisi: [persistence](../test/persistence/persistence_test.dart) | Bellek içi DB ile kayıt/yükleme/silme ve istatistik; çalıştırılmadı, cihaz kalıcılığı kanıtı değil |
| Monetizasyon | Test beklentisi: [monetization](../test/monetization/monetization_test.dart) | Mock reklam, Ads Free ve sandbox payload; çalıştırılmadı, canlı IAP/restore kanıtı değil |
| UI | Test beklentisi: [widgets](../test/widgets/game_widgets_test.dart), [home](../test/widget_test.dart) | Bazı widget ve home smoke beklentileri; çalıştırılmadı |
| SDK / teknik kalite | [pubspec](../pubspec.yaml), [README](../README.md), [lint](../analysis_options.yaml) | Kurulu SDK, analyzer, test, uygulama ve build doğrulaması yok |
| CI / release / kabul | İzlenen dosya listesi ve Git geçmişi | İncelenen kaynaklarda CI/release günlüğü yok; dış servisler/mağazalar/önceki kabul bilinmiyor |
| M0 belge kontrolü | Yürütülmüş belge kontrolü; 18 Ekim 2026, yerel Windows/PowerShell | Beş belgede 95 yerel Markdown bağlantısı: eksik hedef 0; satır sonu boşluk sorunu 0. Kaynak atıfları ve beş dosyanın tüm içeriği/README diff'i incelendi; `git diff --check` ve staged diff kontrolü geçti. İzinli beş dosya dışındaki izlenen dosyalarda HEAD'e göre diff yok; README ve AGENTS bu oturum başlangıcına göre içerik özetiyle aynı. Ürün testi değildir |

## M0 teslimi ve kabul ölçütleri

| Ölçüt | Karşılık |
| --- | --- |
| Kaynaklı bağlam ve açık bulgular | [PROJECT_CONTEXT](PROJECT_CONTEXT.md) ve R1–R10 |
| Tek kanonik kayıt düzeni | PROJECT_CONTEXT kayıt tablosu; roadmap değiştirilmedi |
| Öneri/karar ayrımı | [DECISIONS](DECISIONS.md): yalnız görev yetkisi Accepted; M1 Proposed; ürün konuları Open |
| Doğrulama sınırı | Bu belgenin matrisi; teknik komutlar çalıştırılmadı |
| Mühendislik talimatı / devamlılık | [AGENTS](../AGENTS.md) ve aşağıdaki checkpoint |
| İzin verilen dosya sınırı | HEAD'e göre AGENTS ve üç docs kaydı yeni; README yalnız giriş bağlantısı. Bu oturum başlangıcında beşi de mevcuttu; devam oturumunda yalnız PROJECT_CONTEXT/PROJECT_STATUS/DECISIONS uzlaştırıldı. Diğer kaynaklarda değişiklik yok |

Teknik uygulama engeli M0 kapsamında yok. M0 çıktısının **kullanıcı kabulü bekleniyor**; ürün bulguları çözülmedi. Yeni belgeler henüz commit edilmedi; başka checkout'a Git ile taşınmaları yapılmış sayılmaz.

## Son Continuity Checkpoint — 18 Ekim 2026

- **Proje/amaç:** Number Match mevcut ürünü koruyarak kalıcı bağlam ve çalışma düzeni kurmak.
- **Aktif görev/kapsam:** Mevcut M0 belge kurulumu yeniden kaynaklarla uzlaştırıldı; teslim ve kullanıcı değerlendirmesi aşamasında. Yeni teknik göreve geçilmedi.
- **Kararlar/kaynak:** D-001 kullanıcı görev yetkisi. D-002 M1 Proposed; D-003–D-008 açık. Kaynak: kullanıcının bu oturumda eklediği M0 görev metni; geçmiş ürün kabulü yok.
- **Yetki/sınır:** Yalnız AGENTS, PROJECT_CONTEXT, PROJECT_STATUS, DECISIONS ve README bağlantısı. Roadmap/kod/test/dependency/platform değişikliği ve teknik çalıştırmalar yok. Commit/push/yayın ve başka sohbete mesaj yok.
- **Tamamlanan:** Başlangıçta mevcut kayıt sahipliği, baseline, bulgular, kararlar, mühendislik kuralları ve README bağlantısı korundu. Kaynaklar yeniden karşılaştırıldı; önceki ve güncel başlangıç ayrımı, görev kaynağı ve aktarılmış sohbet bilgisinin sınırı uzlaştırıldı.
- **Doğrulama/sınır:** Yerel Windows/PowerShell ortamında Git ve belge kontrolleri; beş dosyada 95 yerel bağlantı, eksik hedef ve satır sonu boşluk sorunu yok; diff kontrolleri geçti. Test/analyzer/build/cihaz veya canlı servis doğrulaması yok.
- **Açıklar/engeller:** R1–R10 açık; M0 kabulü bekleniyor. Teknik doğrulama/düzeltme için yeni kapsam gerekli.
- **Repository/branch/HEAD:** Number Match uygulama repository'si, `master`, `83a22da902c3db1f5c31a63b873917f3de99a132`; HEAD değişmedi. Son görev çalışma alanı yalnız belirtilen beş belge değişikliğini içerir; commit edilmedi.
- **Kaynaklar/sohbetler:** [Context](PROJECT_CONTEXT.md), [kararlar](DECISIONS.md), [roadmap](POST_MVP_ROADMAP.md), [talimatlar](../AGENTS.md). Handoff hedefi kullanıcı tarafından verilen `00 — HQ | Project Director`; başka sohbet içeriği okunmadı/gönderilmedi.
- **Sonraki somut adım:** Tek parça M0 handoff'unu yönetim HQ'ya kullanıcı taşısın; HQ kabul değerlendirmesi ve Proposed M1 kapsamını ele alsın. M1'in ilk adayı gerçek SDK/araç ortamı ile R1'in analyzer üzerinden doğrulanması; düzeltme veya canlı ödeme/reklam/yayın yetkisi kendiliğinden doğmaz.
- **Asgari devam girdisi:** AGENTS, PROJECT_CONTEXT, bu durum kaydı, ilgili kararlar ve güncel Git durumu. M1'e geçilecekse açık çalıştırma kapsamı. Sohbet geçmişinin tamamı gerekli değildir.

## Son Continuity Checkpoint — 27 Ekim 2026

- **Proje/amaç:** `studio_core_sdk` paketinin Number Match oyununa otonom, mimariyle uyumlu ve derinlemesine entegrasyonu.
- **Aktif görev/kapsam:** Studio Core SDK entegrasyonu; Guest Auth, ServerTimeService, OutboxSyncEngine (0ms mutasyon ve 409 conflict çözümü), LiveOps CMS (game_balance ve dinamik level pack desteği), CurrencyWalletNotifier (güvenli bellek ve disk cüzdanı), RFM Pinch-Point kurtarma teklif akışı, Player Gift Inbox & Cross-Promo, Turnuva Liderlik Tablosu (`submitLeaderboardScore` ve `LeaderboardSheet`), 5-tap gizli QA Developer Console (`StudioDebugOverlay`).
- **Kararlar/kaynak:** Kullanıcı talimatı: `studio_core_sdk` otonom entegrasyonu. Git commit/push yapılmayacak; yapay oyun mekaniği eklenmeyecek; analiz ve testler %100 geçecek.
- **Yetki/sınır:** Kod değişiklikleri ve test dosyaları çalışma alanında uncommitted bırakıldı. Git commit veya push yapılmadı.
- **Tamamlanan:**
  - `pubspec.yaml` ve `pubspec_overrides.yaml` entegrasyonu sağlandı (`studio_core_sdk`).
  - `main.dart`: `StudioSdk.initialize` (Android emülatör / localhost ve offline fallback), Number Match hint distress pinch-point kural kaydı, `StudioDebugOverlay` kök builder sarmalaması eklendi.
  - `RewardService`: `CurrencyWalletNotifier` (`gold`/coins) ile bağlandı; 0ms UI gecikmeli kredi/harcama ve Outbox senkronizasyonu sağlandı; `currentHintCost`, `rewardedAdCoins`, `dailyChallengeRewardCoins` LiveOps manifest parametrelerine bağlandı.
  - `StatsRepositoryImpl`: Oyun sonuçları `OutboxOperationType.levelProgression` ile Outbox kuyruğuna yazıldı ve `StudioVpsAdapter.submitLeaderboardScore` ile turnuva liderlik tablosuna otomatik skor gönderimi bağlandı.
  - `GameRepositoryImpl`: Aktif oyun oturumu ve günlük meydan okuma kayıtları OutboxSyncEngine mutasyon kuyruğuna bağlandı.
  - `GameController`: Timed mod süresi LiveOps `timedRushDurationSeconds` ile yapılandırıldı; `loadRemotePuzzleLevel` ile CMS'ten dinamik puzzle level pack yükleme desteği eklendi; ipucu yetersizliğinde RFM Pinch-Point kurtarma akışı tetiklendi.
  - `BoardGenerator` ve `NumberMatchEngine`: CMS'ten gelen dinamik dizilimleri yükleyebilen `generateBoardFromValues` ve `initCustomLevelGame` eklendi.
  - `HomeScreen`: AppBar'a okunmamış rozet sayaçlı Player Gift Inbox butonu eklendi; modal açılış ve hediye talep akışı bağlandı.
  - `ShopScreen`: `CrossPromoBanner` vitrine eklendi.
  - `StatsScreen`: Turnuva Liderlik Tablosu açılış aksiyonu ve `LeaderboardSheet` bottom sheet bileşeni eklendi.
  - `test/studio_sdk_integration_test.dart`: 7 maddelik kapsamlı uçtan uca doğrulama testi yazıldı (Auth Handshake, Outbox Sync & 409 Conflict, LiveOps Manifest & Dynamic Puzzle Pack, Inbox Claim Flow, RFM Pinch-Point, 5-tap QA Console, UI Sheets).
- **Doğrulama/sınır:**
  - `flutter analyze`: **0 issue** (tamamen temiz).
  - `flutter test`: **48/48 test geçti** (%100 başarı, 41 mevcut + 7 yeni entegrasyon testi).
- **Repository/branch/HEAD:** `master @ 83a22da902c3db1f5c31a63b873917f3de99a132`, tüm değişiklikler uncommitted olarak working tree'de.
- **Sonraki somut adım:** Değişikliklerin kullanıcı tarafından incelenmesi ve onaylanması.

## Son Continuity Checkpoint — 28 Ekim 2026 (Hardened Offline-First Core V1)

- **Proje/amaç:** `studio_core_sdk` paketinin hardened offline-first (`enableCloudSync: false`, `feat/offline-core-hardening-v1`) mimari standartlarında Number Match oyununa tamamen otonom, güvenli ve derinlemesine entegrasyonu.
- **Aktif görev/kapsam:**
  - **Strict Offline-First Bootstrap:** `main.dart` içinde `getApplicationSupportDirectory()` çözümlenerek `StudioSdk.initialize` çağrısı `gameId: 'number_match'`, `storageDirectoryPath: appSupportDir.path`, `enableCloudSync: false`, `enableDebugOverlay: false` ve `initialCurrencies: {gold: 250}` ile başlatıldı. Sıfır ağ paketiyle ilk açılışta kriptografik UUIDv4 `installId` üretilip kalıcı disk vault'una yazılır.
  - **Crash-Safe Persistent Vault:** `lib/data/local/vault/game_state_vault.dart` oluşturuldu. Aktif oyun oturumları (`session_*`), günlük meydan okumalar (`daily_*`) ve oyuncu istatistikleri (`stats_*`) SDK'nın şifreli `EncryptedStorageBox` kutusuna bağlandı. `GameRepositoryImpl` ve `StatsRepositoryImpl` doğrudan bu vault ile senkronize çalışır.
  - **Single-Source Wallet:** Oyun ekonomisi (altın/coin) ve ipucu (hint) harcamaları strictly `StudioSdk.instance.wallet` (`StudioCurrencyIds.gold`) üzerine bağlandı. `RewardService` çift cüzdan durum tutarsızlığını engelleyecek şekilde SDK cüzdanını tek kaynak (single source of truth) olarak dinler.
  - **Local Data Reset:** `SettingsScreen` içine "DATA & STORAGE" bölümü ve "Reset Local Data" butonu eklendi. `StudioSdk.instance.resetLocalGameData(preserveInstallId: true)` çağrısıyla `install_id` korunarak tüm cüzdan ve kasa verileri güvenle sıfırlanabilir.
  - **Performance Hardening:** `GameScreen` içerisindeki 1 saniyelik periyodik timer'ın tüm ekranı (`Scaffold`, `GameBoardWidget`, `GameControlsWidget`) baştan aşağı yeniden çizmesi engellendi. Granüler Riverpod `select` ve `Consumer` sarmalamalarıyla saniyelik re-render'lar yalnızca `GameTimerBadgeWidget` yaprak bileşeniyle sınırlandırıldı.
  - **Monetizasyon ve UI Temizliği:** Mock reklam tamamlama oto-ödülleri, simüle edilmiş ad loop'ları ve sahte IAP satın alma butonları kaldırıldı. `HomeScreen` AppBar'ından ve alt menüsünden çevrimdışı uyumsuz öğeler gizlendi; `StatsScreen` turnuva liderlik banner'ı temizlendi; `ShopScreen` çevrimdışı bilgilendirme ekranına dönüştürüldü; `AdMobPlaceholderAdProvider` ile sıfır ağ ve sıfır sahte ödül sağlayan temiz bir placeholder hook bağlandı.
- **Doğrulama/sınır:**
  - `flutter analyze`: **0 issue** (0 hata, 0 uyarı, 0 lint).
  - `flutter test`: **48/48 test başarılı** (%100 geçiş).
- **Repository/branch/HEAD:** `master @ 83a22da902c3db1f5c31a63b873917f3de99a132`, tüm değişiklikler commit veya push edilmeden uncommitted olarak inceleme için bırakıldı.
- **Sonraki somut adım:** Değişikliklerin kullanıcı tarafından incelenmesi.
