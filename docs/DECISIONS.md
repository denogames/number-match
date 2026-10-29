# Number Match — Karar Kaydı

Bu belge kararların tek kanonik kaydıdır. Teknik bulgular ve doğrulama [PROJECT_STATUS](PROJECT_STATUS.md), roadmap [POST_MVP_ROADMAP](POST_MVP_ROADMAP.md) içindedir. Geçmiş karar gerekçeleri koddan uydurulmaz; eski sohbet bulunursa kaynak ve etkisi açıkça uzlaştırılır.

## Durum sözlüğü

- **Proposed:** öneri; kullanıcı kabulü yok.
- **Open:** karar gerekli, seçenek seçilmedi.
- **Accepted:** kullanıcı/yetkili açıkça kabul etti; sahibi ve kaynağı yazılır.
- **Superseded:** yeni kararla yerini kaybetmiş kayıt; eski kaynak korunur.

Görev yetkisi ürün kabulü değildir. Implemented/Verified/Accepted/Released ayrımı durum belgesindedir.

## D-001 — M0 belge kurulumu ve sınırları

- Durum: **Accepted — yalnız görev kapsamı ve yetkisi**; M0 çıktısının kullanıcı kabulü bekleniyor.
- Karar sahibi: kullanıcı.
- Tarih: 18 Ekim 2026.
- Kaynak: kullanıcının bu Codex oturumunda eklediği “Proje: Number Match / Hedef: Codex Engineering HQ / Görev: M0 — Kalıcı proje bağlamı ve çalışma düzeni” başlıklı görev metni (Pasted text.txt); bölüm 5–6. Başlangıçta mevcut M0 belgeleri bu yetkiyle uzlaştırıldı; yeni teknik kapsam verilmedi.
- Karar: PROJECT_CONTEXT, PROJECT_STATUS, DECISIONS, kök AGENTS ve README belge bağlantısı kurulabilir. Repository kayıtları kanonik; mevcut roadmap korunur.
- Gerekçe: mevcut ürün/mimariyi koruyarak kalıcı bağlam ve sürdürülebilir devam düzeni kurmak.
- Sınır: kod/test/dependency/platform/altyapı değişikliği, test/analyzer/build, kurulum/migration, branch/worktree oluşturma, commit/push/yayın ve başka sohbete mesaj yok.
- Sonuç: M0 belge kurulumu bu yetkiye dayanır; mevcut ürün önerilerine geçmiş onay vermez.

## D-002 — Teknik baseline doğrulaması

- Durum: **Proposed**; yeni görev yetkisi bekleniyor.
- Karar sahibi: henüz yok; kullanıcı/HQ değerlendirmesi gerekli.
- Tarih: 18 Ekim 2026 (öneri kaydı).
- Kaynak: aynı M0 görev mesajı, son bölüm; AI recovery önerisi.
- Öneri/gerekçe: M1 adayı olarak gerçek araç ortamı ve olası IAP derleme engelini doğrulamak, sonra mevcut testler ve seçilecek platformdaki temel akışı değerlendirmek. Çalışırlık kanıtı eksik.
- Sınır: şu an çalıştırma veya düzeltme yetkisi değildir; canlı monetizasyon/yayın dahil sayılmaz. Roadmap'e uygulanmış yeni öncelik değildir.

## D-009 — Hardened Offline-First Core SDK V1 Mimarisi

- Durum: **Implemented / Verified**; kullanıcı incelemesi ve kabulü bekleniyor.
- Karar sahibi: Kullanıcı / Core Hardening Talimatı.
- Tarih: 28 Ekim 2026.
- Karar: `studio_core_sdk` (`feat/offline-core-hardening-v1`) offline-first (`enableCloudSync: false`) olarak projeye entegre edilmiştir. Kriptografik UUIDv4 `installId` ağsız boot edilir; kalıcı oturum ve istatistikler `applicationSupportDirectory` altında `EncryptedStorageBox` (`GameStateVault`) ile saklanır; ekonomi (`RewardService`) doğrudan `StudioSdk.instance.wallet` (`gold`) tek kaynağına bağlanmıştır. Sahte reklam/IAP tetikleyicileri kaldırılmış, AdMob için sıfır ağ ve sıfır sahte ödül içeren placeholder hook oluşturulmuş; saniyelik ekran repaint döngüsü yaprak widget seviyesinde izole edilmiştir.
- Sınır: Git commit veya push yapılmamıştır; değişiklikler çalışma alanında uncommitted olarak bırakılmıştır.

## Açık ürün kararları

| Kimlik | Konu / durum | Karar sahibi | Tarih / kaynak / gerekçe |
| --- | --- | --- | --- |
| D-003 | **Open:** İlk hedef platform ve mevcut yayın kimliği/durumu | Kullanıcı; cevap bilinmiyor | 18 Ekim 2026 kayıt; [R5/R10](PROJECT_STATUS.md), platform klasörü yayın kabulü kanıtı değil |
| D-004 | **Open:** Timed 120/180 saniye ve zaman bonusları | Kullanıcı; seçim yok | 18 Ekim 2026 kayıt; [R6](PROJECT_STATUS.md), belge/sabit/motor çelişkisi |
| D-005 | **Open:** Daily tarih/saat dilimi, gün değişiminde devam/tamamlama | Kullanıcı; seçim yok | 18 Ekim 2026 kayıt; [R7](PROJECT_STATUS.md), tarih sürekliliği riski |
| D-006 | **Open:** Pause, menüye dönüş ve arka planda timer davranışı | Kullanıcı; seçim yok | 18 Ekim 2026 kayıt; [R8](PROJECT_STATUS.md), görünür pause ile timer akışı arasındaki belirsizlik |
| D-007 | **Open:** Boş ipucu ücretlendirmesi ve undo/coin ödül sözleşmesi | Kullanıcı; seçim yok | 18 Ekim 2026 kayıt; [R9](PROJECT_STATUS.md), ekonomi tutarlılığı |
| D-008 | **Open:** Mevcut post-MVP önceliklerinin kabulü | Kullanıcı; geçmiş onay bilinmiyor | 18 Ekim 2026 kayıt; [mevcut roadmap](POST_MVP_ROADMAP.md), belge sırası kullanıcı kararı sayılmadı |

Bu konular M0'ı engellemez; ilgili teknik/ürün aşamasında ele alınır. Persona, yaş/pazar, iş hedefi ve başarı metriği de bilinmiyor; bu kayıt bunlar için yeni ürün vizyonu seçmez.
