# Message Analysis Evaluation Cases (TR)

This document contains 30 Turkish sample messages for testing the AI Message Analysis engine. These cases cover various emotional tones, manipulative patterns, and logistical needs.

| # | Message | Category | Expected Risk | Expected Action | Expected Patterns |
|---|---------|----------|---------------|-----------------|-------------------|
| 1 | "Seni özledim" | Emotional Pull | Medium | Wait / No Reply | Emotional Hook |
| 2 | "Hemen cevap ver, telefonlarımı neden açmıyorsun?" | Pressure / Urgency | High | Do Not Reply | False Urgency, Pressure |
| 3 | "Senin yüzünden böyle olduk, her şeyi mahvettin." | Guilt-tripping | High | Do Not Reply | Blame, Guilt-trip |
| 4 | "Sadece nasılsın diye yazdım, aklıma geldin." | Breadcrumbing | Medium | Wait / No Reply | Casual Check-in, Breadcrumbing |
| 5 | "Eşyalarımı ne zaman alabilirim? Salı günü mü geleyim?" | Logistical | Low | Reply with Boundary | Logistics, Neutral |
| 6 | "Bir kahve içelim mi? Sadece konuşuruz." | Boundary Testing | Medium | No Reply / Boundary | Re-engagement attempt |
| 7 | "Değiştim, söz veriyorum her şey farklı olacak." | Future Faking | High | Do Not Reply | False Promise, Future Faking |
| 8 | "Bana bunu borçlusun, en azından bir açıklamayı hak ediyorum." | Entitlement | High | Do Not Reply | Obligation, Guilt |
| 9 | "Kitabın bende kalmış, kargolayayım mı?" | Logistical | Low | Reply with Boundary | Logistics |
| 10 | "Özür dilerim, her şey için çok üzgünüm." | Apology | Medium | Wait / Unsent Letter | Emotional Pull |
| 11 | "Senin gibisini asla bulamayacağım." | Idealization / Despair | Medium | Wait / No Reply | Self-depreciation, Hook |
| 12 | "Yeni birini mi buldun? O yüzden mi yazmıyorsun?" | Jealousy / Provocation | High | Do Not Reply | Accusation, Provocation |
| 13 | "Kedimiz seni çok özledi, sürekli kapıya bakıyor." | Emotional Hook (Triangulation) | High | No Reply | Use of third party/pet as hook |
| 14 | "Param kalmadı, bana biraz borç verebilir misin?" | Financial Pressure | High | Do Not Reply | Practical hook, Pressure |
| 15 | "Çok hastayım, hastanedeyim. Kimse yok yanımda." | Crisis Hook | High | Use SOS / Verify independently | Vulnerability, Pressure |
| 16 | "Eski fotoğraflarımıza bakıyorum, ne kadar mutluyduk." | Nostalgia Hook | Medium | Wait / Unsent Letter | Nostalgia, Sentimentality |
| 17 | "Sen bencil birisin, sadece kendini düşünüyorsun." | Projection / Insult | High | Do Not Reply | Character Attack |
| 18 | "Eşyalarını kapının önüne bıraktım, gel al." | Logistical / Aggressive | Medium | Reply with Boundary | Logistics, Dismissal |
| 19 | "Rüyamda seni gördüm, çok kötüydün. İyi misin?" | Concern Hook | Medium | No Reply | Intuition/Dream as excuse |
| 20 | "Artık tamamen bitti, bir daha sakın arama." | Closure / Finality | Medium | No Reply | Finality (Respect the boundary) |
| 21 | "Biliyorum çok kızgınsın ama lütfen dinle." | Pleading | Medium | No Reply | Minimizing anger, Pleading |
| 22 | "Senin için aldığım hediye geldi, ne yapayım?" | Gift Hook | Medium | Reply with Boundary | Tangible connection attempt |
| 23 | "Ortak arkadaşımız Mert kaza yapmış." | Information Hook | High | Verify via Mert/Others | Third party news as hook |
| 24 | "Dün akşam seni biriyle gördüm." | Monitoring / Stalking | High | Do Not Reply | Surveillance, Provocation |
| 25 | "Faturalar senin üzerine kalmış, onları ödemem lazım." | Logistical | Low | Reply with Boundary | Admin/Finance |
| 26 | "Seni sevmekten asla vazgeçmeyeceğim." | Love Bombing | High | No Reply | Excessive sentimentality |
| 27 | "Nefret ediyorum senden, hayatımı mahvettin." | Rage / Split | High | Do Not Reply | Verbal Abuse |
| 28 | "Hatırlıyor musun bu şarkıyı? Bizim şarkımızdı." | Shared Memory Hook | Medium | Wait / Unsent Letter | Nostalgia |
| 29 | "Sadece bir eşyamı sormak için yazmıştım, kusura bakma." | False Polite Hook | Low | Reply with Boundary | Minimizing contact |
| 30 | "Mutlu musun şimdi? İstediğin oldu." | Passive Aggressive | High | Do Not Reply | Sarcasm, Guilt |

## Prompt Evaluation Rules
- **Risk Level High**: Direct insults, threats, extreme guilt-tripping, or urgent pressure to break NC.
- **Risk Level Medium**: Casual "checking in", nostalgia, soft emotional hooks, breadcrumbing.
- **Risk Level Low**: Purely logistical, neutral, or practical matters (bills, pets, clothes).

## Expected Recommendations
- **Do Not Reply**: High risk, manipulative, or splitting messages.
- **Wait 24h**: Emotional messages that aren't urgent but trigger the user.
- **Reply with Boundary**: Pure logistics (Short, neutral, "Gray Rock").
- **Use SOS**: If the user feels overwhelmed by the contact.
- **Write Unsent Letter**: When the user has a strong emotional urge to respond to an apology or nostalgia.
