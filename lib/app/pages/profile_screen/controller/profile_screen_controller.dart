import 'dart:developer';

import 'package:atlas_mobile/app/model/event.model.dart';
import 'package:atlas_mobile/app/model/memory.model.dart';
import 'package:atlas_mobile/app/model/post.model.dart';
import 'package:atlas_mobile/app/model/scrapbook.model.dart';
import 'package:atlas_mobile/app/model/user.model.dart';
import 'package:atlas_mobile/app/pages/events_screen/views/events_details_screen.dart';
import 'package:atlas_mobile/app/services/event/event.service.dart';
import 'package:atlas_mobile/app/services/memories/memories.service.dart';
import 'package:atlas_mobile/app/services/post/post.service.dart';
import 'package:atlas_mobile/app/services/user/user.service.dart';
import 'package:atlas_mobile/app/utility/shared_preferences.dart';
import 'package:atlas_mobile/app/widgets/post_details/post_details.dart';
import 'package:atlas_mobile/app/widgets/scrapbook_details/scrapbook_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../widgets/memory_details/memory_details.dart';

class ProfileScreenController extends GetxController {
  double width = Get.width;
  double height = Get.height;
  var isLoading = false.obs;
  User user = User();
  ScrollController postsScrollController = ScrollController();
  ScrollController scrapbookScrollController = ScrollController();
  ScrollController memoriesScrollController = ScrollController();
  ScrollController eventsScrollController = ScrollController();
  ScrollController joinedEventsScrollController = ScrollController();

  var postsList = <Post>[].obs;
  var scrapbooksList = <Scrapbook>[].obs;
  var memoriesList = <Memory>[].obs;
  var eventsList = <Event>[].obs;
  var joinedEventsList = <Event>[].obs;

  var isDisplayingPosts = false.obs;
  var isDisplayingMemories = false.obs;
  var isDisplayingScrapbooks = false.obs;
  var isDisplayingEvents = false.obs;
  var postHasNextPage = false.obs;
  var scrapbookHasNextPage = false.obs;
  var memoryHasNextPage = false.obs;
  var eventHasNextPage = false.obs;
  var joinedEventHasNextPage = false.obs;
  var isJoinedEventsSelected = false.obs;

  int postPage = 1;
  int scrapbookPage = 1;
  int memoryPage = 1;
  int eventPage = 1;
  int joinedEventsPage = 1;

  @override
  void onInit() {
    super.onInit();
    postsScrollController.addListener(_postsScrollListener);
    scrapbookScrollController.addListener(_scrapbookScrollListener);
    memoriesScrollController.addListener(_memoryScrollListener);
    eventsScrollController.addListener(_eventScrollListener);
    joinedEventsScrollController.addListener(_joinedEventScrollListener);
  }

  @override
  void dispose() {
    postsScrollController.removeListener(_postsScrollListener);
    postsScrollController.dispose();
    scrapbookScrollController.removeListener(_scrapbookScrollListener);
    scrapbookScrollController.dispose();
    memoriesScrollController.removeListener(_memoryScrollListener);
    memoriesScrollController.dispose();
    eventsScrollController.removeListener(_eventScrollListener);
    eventsScrollController.dispose();
    joinedEventsScrollController.removeListener(_joinedEventScrollListener);
    joinedEventsScrollController.dispose();
    super.dispose();
  }

  void _postsScrollListener() {
    if (postsScrollController.positions.last.pixels ==
        postsScrollController.positions.last.maxScrollExtent) {
      getMorePosts();
    }
  }

  void _scrapbookScrollListener() {
    if (scrapbookScrollController.positions.last.pixels ==
        scrapbookScrollController.positions.last.maxScrollExtent) {
      getMoreScrapbooks();
    }
  }

  void _memoryScrollListener() {
    if (memoriesScrollController.positions.last.pixels ==
        memoriesScrollController.positions.last.maxScrollExtent) {
      getMoreUserMemories();
    }
  }

  void _eventScrollListener() {
    if (eventsScrollController.positions.last.pixels ==
        eventsScrollController.positions.last.maxScrollExtent) {
      getMoreUserEvents();
    }
  }

  void _joinedEventScrollListener() {
    if (joinedEventsScrollController.positions.last.pixels ==
        joinedEventsScrollController.positions.last.maxScrollExtent) {
      getMoreJoinedEvents();
    }
  }

  loadData() {
    getUserProfile();
    postPage = 1;
    displayUserPosts();
  }

  getUserProfile() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final userService = UserService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    userService.getUserProfile('Bearer $accessToken').then((response) {
      user = response;
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserPosts() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService.getUserPosts('Bearer $accessToken', postPage).then((response) {
      postsList.assignAll(response.posts!);
      postHasNextPage.value = response.meta!.hasNextPage!;
      if (postHasNextPage.value) {
        postPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  displayUserPosts() {
    if (isDisplayingPosts.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = true;
      isDisplayingScrapbooks.value = false;
      if (postPage == 1) {
        getUserPosts();
      }
    }
  }

  displayUserMemories() {
    if (isDisplayingMemories.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = true;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = false;
      if (memoryPage == 1) {
        getUserMemories();
      }
    }
  }

  displayUserScrapbooks() {
    if (isDisplayingScrapbooks.value == false) {
      isDisplayingEvents.value = false;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = true;
      if (scrapbookPage == 1) {
        getUserScrapbooks();
      }
    }
  }

  displayUserEvents() {
    if (isDisplayingEvents.value == false) {
      isDisplayingEvents.value = true;
      isDisplayingMemories.value = false;
      isDisplayingPosts.value = false;
      isDisplayingScrapbooks.value = false;
      if (eventPage == 1 && !isJoinedEventsSelected.value) {
        getUserEvents();
      }

      if (joinedEventsPage == 1 && isJoinedEventsSelected.value) {
        getJoinedEvents();
      }
    }
  }

  getUserMemories() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final memoriesService = MemoriesService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    memoriesService
        .getUserMemories('Bearer $accessToken', memoryPage)
        .then((response) {
      memoriesList.assignAll(response.memories!);
      memoryHasNextPage.value = response.meta!.hasNextPage!;
      if (memoryHasNextPage.value) {
        memoryPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserScrapbooks() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    postService
        .getUserScrapbooks('Bearer $accessToken', scrapbookPage)
        .then((response) {
      scrapbooksList.assignAll(response.scrapbooks!);
      scrapbookHasNextPage.value = response.meta!.hasNextPage!;
      if (scrapbookHasNextPage.value) {
        scrapbookPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getUserEvents() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    eventsService
        .getUserEvents('Bearer $accessToken', eventPage)
        .then((response) {
      eventsList.assignAll(response.events!);
      eventHasNextPage.value = response.meta!.hasNextPage!;
      if (eventHasNextPage.value) {
        eventPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getJoinedEvents() async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    eventsService
        .getJoinedEvents('Bearer $accessToken', joinedEventsPage)
        .then((response) {
      joinedEventsList.assignAll(response.events!);
      joinedEventHasNextPage.value = response.meta!.hasNextPage!;
      if (joinedEventHasNextPage.value) {
        eventPage++;
      }
      toggleLoading();
    }).catchError((error) {
      log(error.toString());
    });
  }

  getMorePosts() async {
    if (postHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final postService = PostService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      postService
          .getUserPosts('Bearer $accessToken', postPage)
          .then((response) {
        postsList.value.addAll(response.posts!);
        postHasNextPage.value = response.meta!.hasNextPage!;
        if (postHasNextPage.value) {
          postPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getMoreScrapbooks() async {
    if (scrapbookHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final postService = PostService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      postService
          .getUserScrapbooks('Bearer $accessToken', scrapbookPage)
          .then((response) {
        scrapbooksList.value.addAll(response.scrapbooks!);
        scrapbookHasNextPage.value = response.meta!.hasNextPage!;
        if (scrapbookHasNextPage.value) {
          scrapbookPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getMoreUserMemories() async {
    if (memoryHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final memoriesService = MemoriesService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      memoriesService
          .getUserMemories('Bearer $accessToken', memoryPage)
          .then((response) {
        memoriesList.addAll(response.memories!);
        memoryHasNextPage.value = response.meta!.hasNextPage!;
        if (memoryHasNextPage.value) {
          memoryPage++;
        }
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getMoreUserEvents() async {
    if (eventHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final eventsService = EventsService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      eventsService
          .getUserEvents('Bearer $accessToken', eventPage)
          .then((response) {
        eventsList.addAll(response.events!);
        eventHasNextPage.value = response.meta!.hasNextPage!;
        if (eventHasNextPage.value) {
          eventPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getMoreJoinedEvents() async {
    if (joinedEventHasNextPage.value) {
      toggleLoading();
      final dio = Dio(); // Provide a dio instance
      final eventsService = EventsService(dio);

      final accessToken =
          await SharedPreferencesService.getFromShared('accessToken');

      eventsService
          .getJoinedEvents('Bearer $accessToken', joinedEventsPage)
          .then((response) {
        joinedEventsList.addAll(response.events!);
        joinedEventHasNextPage.value = response.meta!.hasNextPage!;
        if (joinedEventHasNextPage.value) {
          joinedEventsPage++;
        }
        toggleLoading();
      }).catchError((error) {
        log(error.toString());
      });
    }
  }

  getCurrentPost(String postId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    return postService
        .getPostById('Bearer $accessToken', postId)
        .then((response) {
      toggleLoading();
      return response;
    }).catchError((error) {
      log(error.toString());
    });
  }

  getCurrentScrapbook(String scrapbookId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final postService = PostService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    return postService
        .getScrapbookById('Bearer $accessToken', scrapbookId)
        .then((response) {
      toggleLoading();
      return response;
    }).catchError((error) {
      log(error.toString());
    });
  }

  openPostDetails(String postId) async {
    Post detailedPost = await getCurrentPost(postId);
    Get.to(() =>
        PostDetailsScreen(post: detailedPost, height: height, width: width));
  }

  openScrapbookDetails(String scrapbookId) async {
    Scrapbook detailedScrapbook = await getCurrentScrapbook(scrapbookId);
    Get.to(() => ScrapbookDetailsScreen(
        scrapbook: detailedScrapbook, height: height, width: width));
  }

  getScrapbookThumbnail(List<Post> posts) {
    if (posts.isNotEmpty) {
      for (var post in posts) {
        if (post.imageUrl?.isNotEmpty ?? false) {
          return post.imageUrl ?? '';
        }
      }
    } else {
      return '';
    }

    return '';
  }

  getCurrentEvent(String eventId) async {
    toggleLoading();
    final dio = Dio(); // Provide a dio instance
    final eventsService = EventsService(dio);

    final accessToken =
        await SharedPreferencesService.getFromShared('accessToken');

    return eventsService
        .getEventById('Bearer $accessToken', eventId)
        .then((response) {
      toggleLoading();
      return response;
    }).catchError((error) {
      log(error.toString());
    });
  }

  openMemoryDetails(Memory memory) {
    Get.to(() => MemoryDetailsScreen(memory: memory));
  }

  openEventDetails(Event event) async {
    Event detailedEvent = await getCurrentEvent(event.id!);

    Get.to(() => EventDetailsScreen(event: detailedEvent));
  }

  toggleJoinedEventsSelected() {
    isJoinedEventsSelected.value = !isJoinedEventsSelected.value;

    if (isJoinedEventsSelected.value) {
      getJoinedEvents();
    }
  }
}
