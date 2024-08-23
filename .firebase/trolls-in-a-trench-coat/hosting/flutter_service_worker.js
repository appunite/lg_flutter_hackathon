'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "c54f5aa6bead527f6a3030a307a9672b",
"index.html": "0d477a111a918943c8891b8a1d70e2f9",
"/": "0d477a111a918943c8891b8a1d70e2f9",
"main.dart.js": "88adfdc5d8ae4e92d7cc5a7f30b915c0",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "88e3faefd4369ec088dc19d58a0238f8",
"assets/AssetManifest.json": "26eb168d03bd45aa8681bbedeb78bda0",
"assets/NOTICES": "bb373f005335dd9b5270ba03faeb4ebf",
"assets/FontManifest.json": "d03b5041a7bc99b64dd08a1edcca5960",
"assets/AssetManifest.bin.json": "cd661d3e6ff512929d49af8054c0e117",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "86915f302cd610addefc731d613cf717",
"assets/fonts/MaterialIcons-Regular.otf": "507cc52d11047e925f6ee1639c40aa9d",
"assets/assets/music/main_screen_music2.mp3": "97566118e297799b3258af34f3bae77a",
"assets/assets/music/main_screen_music1.mp3": "47093ac0782c5c78c6454418bca6887e",
"assets/assets/sfx/sh1.mp3": "f695db540ae0ea850ecbb341a825a47b",
"assets/assets/sfx/dsht1.mp3": "c99ece72f0957a9eaf52ade494465946",
"assets/assets/videos/background_movie.json": "7eab0e4e80a5e2c53d55a93988e9ac05",
"assets/assets/ilustrations/cottage.svg": "419218406b0dcf0e6e92e837e5b21555",
"assets/assets/ilustrations/splash_background.svg": "27af1d3fca12b4130cc47d8e5f374f1b",
"assets/assets/ilustrations/play_again.svg": "5446b6740a8c0ac9c931c23c4480214c",
"assets/assets/ilustrations/glyphs/glyph_3_compare.png": "3d8d35ca4149bab01497f6f02da3ff02",
"assets/assets/ilustrations/glyphs/glyph_9_presentation.png": "348de3d2e92919af2e7e5b49d23d60fc",
"assets/assets/ilustrations/glyphs/glyph_2_presentation.png": "987319ef975af389416f076f35a34331",
"assets/assets/ilustrations/glyphs/glyph_11_compare.png": "5f6e547f4c19882064cf16828c772b8b",
"assets/assets/ilustrations/glyphs/glyph_6_presentation.png": "51519114b5b73142e5ff56572fee3c68",
"assets/assets/ilustrations/glyphs/glyph_10_presentation.png": "186a9e79b70463bcb69a726e3a32384e",
"assets/assets/ilustrations/glyphs/glyph_6_compare.png": "74e1519969d7b91e753c415fed4428a8",
"assets/assets/ilustrations/glyphs/glyph_8_presentation.png": "9d7bb916ad504c07ca41ff0d49844945",
"assets/assets/ilustrations/glyphs/glyph_5_compare.png": "622b340f63efbd39aa8a55672da392ec",
"assets/assets/ilustrations/glyphs/glyph_3_presentation.png": "51145f6ecc5fe902c6c55a0bf741eb81",
"assets/assets/ilustrations/glyphs/glyph_11_presentation.png": "600b1cedc6b5ed0c99cac95c70690203",
"assets/assets/ilustrations/glyphs/glyph_9_compare.png": "1e5bf1bab40cc2c58ed37d25cb8b8b9c",
"assets/assets/ilustrations/glyphs/glyph_7_presentation.png": "5c2c6a24bbd1c3a6b50b7fe06fef3cd5",
"assets/assets/ilustrations/glyphs/glyph_7_compare.png": "39f8ab68a7ab77367f95d1193856bf70",
"assets/assets/ilustrations/glyphs/glyph_10_compare.png": "a27487faa07081fa5dd207d6c1cbfc3a",
"assets/assets/ilustrations/glyphs/glyph_4_presentation.png": "9023207c63ad4eea51b91e17046834f7",
"assets/assets/ilustrations/glyphs/glyph_2_compare.png": "803933ff28d9c50a2fccf40f20483c4f",
"assets/assets/ilustrations/glyphs/glyph_1_compare.png": "5fcb447126b30f0e5fd49d35f332c7ad",
"assets/assets/ilustrations/glyphs/glyph_1_presentation.png": "13a405563da8625f06648388c916801e",
"assets/assets/ilustrations/glyphs/glyph_8_compare.png": "934b80369b8438b5d71fea21876fc7fd",
"assets/assets/ilustrations/glyphs/glyph_5_presentation.png": "24b29c371c62fc1c15e023678d57c0d1",
"assets/assets/ilustrations/glyphs/glyph_4_compare.png": "c35ebe9c99f845979d29220f0e49841e",
"assets/assets/ilustrations/story_stick.svg": "528318d70b1142ad4e0e6de669e0a93e",
"assets/assets/ilustrations/hourglass.svg": "8a16c1a4393f213e8d60da2ad81c843d",
"assets/assets/ilustrations/coat_floor.svg": "c13522bfee389eedfed6a5b22bbf0394",
"assets/assets/ilustrations/mashrooms.svg": "ca3db6eeaf23d2082ffdc354c5e65d13",
"assets/assets/ilustrations/pick_players_container.svg": "76b29dcfa387901c884de01d8a84fff8",
"assets/assets/ilustrations/ok_button.svg": "434c37b3d4a0d06bda7021217c36305f",
"assets/assets/ilustrations/players.svg": "4cce8af7c1f4db3e08740bf758513713",
"assets/assets/ilustrations/round.svg": "5cae74254987f2cbeb35f9de58b9308a",
"assets/assets/ilustrations/city.svg": "49ea8efd9c251557e9cc4f206b0a552a",
"assets/assets/ilustrations/coat_trolls.svg": "481b189f6d3deb3d9bdef4c34284a525",
"assets/assets/ilustrations/player_name_red.svg": "af41d17f12f73c628e67a52854b64e59",
"assets/assets/ilustrations/game_stats_player_1.svg": "5de4fb572e09c8be9d329657ec05c447",
"assets/assets/ilustrations/game_stats_point_first_row.svg": "ecbd0ee96f0ed48ea0e47afa5aec3cc4",
"assets/assets/ilustrations/game_stats_player_3.svg": "fd005ca34ec0c4b7f7cd3ff6ec36336e",
"assets/assets/ilustrations/keys.svg": "3aaba61302f7865c31b56c95f07d9e45",
"assets/assets/ilustrations/health_bar_foreground.svg": "9232bd88bf879eaa842bc1f75a532c41",
"assets/assets/ilustrations/game_stats_player_2.svg": "dac17f306bd5b947307c8bbef2e18a1b",
"assets/assets/ilustrations/castle.svg": "b056fc5e922af8f1abe6fd7812da2325",
"assets/assets/ilustrations/troll_enemy.svg": "978bd6b92703bdff484e896a540d73b1",
"assets/assets/ilustrations/wallet.svg": "581392a933885e4b7eabb8b60e7ed3a9",
"assets/assets/ilustrations/story_stick_troll.svg": "865017a099d161cebcbdaf4673fe2dfd",
"assets/assets/ilustrations/fountain_trolls.svg": "00a8eeee497ce00d40b7d13c5c7d77b5",
"assets/assets/ilustrations/bomb.svg": "9963923fcdb3763bbeafd8a65f1a2d56",
"assets/assets/ilustrations/drawing_board.svg": "35293bdacd309c747ba344c69cb5b6e4",
"assets/assets/ilustrations/bonus_stand.svg": "efa0d27544be6c17fbff4af7e5aca53b",
"assets/assets/ilustrations/player_red.svg": "d6feb58d2d820e1d30edac9ddba2be2a",
"assets/assets/ilustrations/game_stats_player_4.svg": "52587c2a034565397cc9995db2389073",
"assets/assets/ilustrations/game_stats_point_second_row.svg": "bb831f7ee3cde0493a4d3d0d0426b629",
"assets/assets/ilustrations/loader.svg": "26d2714c0101b51fa28f542096912dbb",
"assets/assets/ilustrations/player_name_blue.svg": "d6b17e06c457a3f2e4c55447c6ed52b4",
"assets/assets/ilustrations/palms.svg": "5b9f422d4c92a347739fed6ddad33e7d",
"assets/assets/ilustrations/player_yellow.svg": "3362fa9a27229513db3d418d7fa33259",
"assets/assets/ilustrations/start.svg": "24126fa6e5f599d17347e681f28b3ca0",
"assets/assets/ilustrations/game_result_holder.svg": "7c168ac103e62b65e622716c39d7d3d4",
"assets/assets/ilustrations/player_name_green.svg": "549a9fc3316ac7a94292623dba12caf1",
"assets/assets/ilustrations/pick_players_background.svg": "f8f597a48d209d07e4098cd44210a6c7",
"assets/assets/ilustrations/bonuses_background.svg": "981300343c2473721cd26269ed28c729",
"assets/assets/ilustrations/player_green.svg": "05a1e186586de36a2807df7570c925f0",
"assets/assets/ilustrations/player_name_yellow.svg": "fdf467cbf1e83fdfeff5ddcded0c4959",
"assets/assets/ilustrations/kitchen.svg": "d128de1a7b02dce6af3e0dfbaa1728a3",
"assets/assets/ilustrations/drops.svg": "5d005a38802bec334a081747b834de48",
"assets/assets/ilustrations/underwood.svg": "f19f0a6f2147d983e892e549f9189a82",
"assets/assets/ilustrations/red_elixir.svg": "e4ad8016e10d13bab4df36e6f7038548",
"assets/assets/ilustrations/green_elixir.svg": "233afc141a5b08200e201e564c4048c5",
"assets/assets/ilustrations/pick_players_left_button.svg": "569eef74c51a68faa3a0801d24ec530d",
"assets/assets/ilustrations/battle_background.svg": "06a6c165c846e8369f6a2e8f165ef9bd",
"assets/assets/ilustrations/forest_trolls.svg": "98c520406493727505c3871b18f28099",
"assets/assets/ilustrations/pick_players_numbers_container.svg": "f299e17fc076b2d93ae36c1288f5362b",
"assets/assets/ilustrations/findings.svg": "1d66de8cb8988ac61751602b0c7d7206",
"assets/assets/ilustrations/player_blue.svg": "d6fa937e55c2fd0e244fdcd13c71eb11",
"assets/assets/ilustrations/button_next.svg": "38f9ad41fbd43f87ae7e919087f72ba1",
"assets/assets/ilustrations/game_stats_background.svg": "3cfdb841afde07cb6528d7099c9b87a5",
"assets/assets/ilustrations/magic_pen.svg": "e71c276281e36ac22992423c028c49fa",
"assets/assets/ilustrations/loader_background.svg": "105c5514406d04f12e2ebdab41d011ab",
"assets/assets/ilustrations/pick_players_right_button.svg": "7b82145b057734c0c6e58fedee3e68e5",
"assets/assets/ilustrations/coat.svg": "963f151af2f1cfc187f3edc0b2f2536c",
"assets/assets/ilustrations/pick_players_accept_button.svg": "24126fa6e5f599d17347e681f28b3ca0",
"assets/assets/ilustrations/loader_container.svg": "0e5dd2905df2a94575d380f2727892d0",
"assets/assets/ilustrations/sword.svg": "748bcee42af7b86a20783ef30b9b74a6",
"assets/assets/ilustrations/man.svg": "e1db723f69b11a73dae5cd7f11ec77db",
"assets/assets/ilustrations/health_bar_background.svg": "9b22e5a51d77b8c413a9cc7c1cbca575",
"assets/assets/ilustrations/board_background.svg": "1d50815d61fc08914c52faabb0fbc875",
"assets/assets/fonts/Knewave-Regular.ttf": "f77e1ba76d6ce86a4639dce4a09b2db5",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
