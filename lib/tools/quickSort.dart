class QuickSort {
  static partitionFunc(int left, int right, dynamic nums) {
    int pivot = nums[right];
    int pointer = left;
    var temp;
    for (int i = left; i < right; i++) {
      if (nums[i] <= pivot) {
        temp = nums[pointer];
        nums[pointer] = nums[i];
        nums[i] = temp;
        pointer++;
      }
    }
    temp = nums[pointer];
    nums[pointer] = nums[right];
    nums[right] = nums[pointer];
    return pointer;
  }

  static sort(left, right, nums) {
    var pi;
    if (nums.length == 1) {
      return nums;
    }
    if (left < right) {
      pi = QuickSort.partitionFunc(left, right, nums);
      QuickSort.sort(left, pi - 1, nums);
      QuickSort.sort(pi + 1, right, nums);
    }
    return nums;
  }
}
