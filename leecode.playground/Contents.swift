//: # Leetcode study 75
//: > [Link to leetcode](https://leetcode.com/studyplan/leetcode-75/)

import UIKit
import Foundation

class MergeAlternativeString {
    func mergeAlternately(_ word1: String, _ word2: String) -> String {
        if word1.count <= 0 {
            return word2
        }

        if word2.count <= 0 {
            return word1
        }

        var result = String()

        let m = word1.endIndex
        let n = word2.endIndex

        var i = word1.startIndex
        var j = word2.startIndex

        while (i<m || j<n) {
            if (i<m) {
                result.append(word1[i])
                i = word1.index(after: i)
            }
            if (j<n) {
                result.append(word2[j])
                j = word2.index(after: j)
            }
        }

        return result
    }

    func mergeAlternatelySinglePointer(_ word1: String, _ word2: String) -> String {
        if word1.count <= 0 {
            return word2
        }
        if word2.count <= 0 {
            return word1
        }
        var result = String()
        let m = word1.endIndex
        let n = word2.endIndex
        let maxLengthWord = m > n ? word1 : word2
        let maxLengthEndIndex = maxLengthWord.endIndex
        var i = maxLengthWord.startIndex

        while (i < maxLengthEndIndex) {
            if (i<m) {
                result.append(word1[i])
            }
            if (i<n) {
                result.append(word2[i])
            }
            i = maxLengthWord.index(after: i)
        }

        return result
    }
}

//: # Greatest Common Divisor of Strings
//: > [link](https://leetcode.com/problems/greatest-common-divisor-of-strings/description/?envType=study-plan-v2&envId=leetcode-75)
//: complaxity:
//: Time: O(min(m,n)⋅(m+n)). Space: O(min(m,n))
class GcdOfStrings {

    func gcdOfStrings(_ str1: String, _ str2: String) -> String {
        let len1 = str1.count
        let len2 = str2.count

        func validate(k: Int) -> Bool {

            // check if length of string 1 or string 2 can be completely divided by given prefix length.
            // if not then return false indicating the substring is not valid GCD
            if (len1 % k != 0 || len2 % k != 0) {
                return false
            }

            // take the ration which can completely divide both str1 and str2
            let n1 = len1 / k
            let n2 = len2 / k
            // form the base by taking the prefix of str1 with k values
            let base = String(str1.prefix(k))
            
            //compare if str1 and str2 can be reformed by multiplying base n1 and n2 times
            return str1 == String(repeating: base, count: n1) && str2 == String(repeating: base, count: n2)
        }

        // stride from taking the smallest input string in decreasing order
        for i in stride(from: min(len1, len2), through: 1, by: -1) {
            // for each string substring check for gcd
            if validate(k: i) {
                return String(str1.prefix(i))
            }
        }
        return ""
    }
}

// Example usage:
let gcdOfStringsClass = GcdOfStrings()
let result = gcdOfStringsClass.gcdOfStrings("ABAB", "AB")
print(result)  // Output: "ABC"



//: # Kids with Candies
//: > We are given an integer array candies, where each candies[i] represents the number of candies the i'th  kid has, and an integer extraCandies, denoting the number of extra candies that you have. Our task is to return a boolean array result of length n, where result[i] is true if, after giving the i'th kid all the extraCandies, they will have the greatest number of candies among all the kids, or false otherwise.
//: ---
//: * time: O(n)
//: * space: O(1)
class KidsWithCandiesSolution {
    func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {

        // Get the Max element in the list by comparing all the elements
        let maxCount = candies.reduce(0) { partialResult, nextResult in
            max(partialResult, nextResult)
        }

        // Compare each element in the list by adding extraCandies to the el
        return candies.map { item in
            item + extraCandies >= maxCount
        }
    }
}

let kidsSolution = KidsWithCandiesSolution()
let candies = [2,3,5,1,3]
let KidsCandiesResult = kidsSolution.kidsWithCandies(candies, 3)

//: # Can Place Flowers
//: You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.
//: ***
//: Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.
//: ***
//: * time: O(n)
//: * space: O(1)

class CanPlaceFlowersSolution {
    
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        var flowerbed = flowerbed
        // count of empty space with adjucent empty spaces
        var count = 0

        for i in stride(from: 0, through: flowerbed.count - 1, by: 1) {
            if flowerbed[i] == 0 {
                // check if its the starting index or the previous item is 0
                let emptyLeftPlot = (i == 0 || flowerbed[i - 1] == 0)
                // check for end index or next time is 0
                let emptyRightPlot = (i == flowerbed.count - 1 || flowerbed[i + 1] == 0)
                // if both right and left plots are empty increase the count
                if emptyLeftPlot && emptyRightPlot {
                    // increment count by 1
                    count += 1
                    //mark the Plot as 1, as subsequent 0's will not lead to error
                    flowerbed[i] = 1
                    // if count is greater than n, return immediately
                    if count >= n {
                        return true
                    }
                }
            }
        }
        return count >= n
    }
}

let canPlaceFlower = CanPlaceFlowersSolution()
let flowerbed = [1,0,0,0,1]
let canPlaceFlowerResult = canPlaceFlower.canPlaceFlowers(flowerbed, 2)


//: # Reverse Vowels of a String
//: Given a string s, reverse only all the vowels in the string and return it.
//: ***
//: The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.
//: ***
//: * Time: O(n)
//: * Space O(1)
class ReverseVowelsSolution {
    func reverseVowels(_ s: String) -> String {
        // left pointer
        var left = 0
        //right pointer
        var right = s.count - 1
        //list of vowels in set of char
        let vowels : Set<Character> = Set("aeiouAEIOU")
        // convert string to array of char for easy indexing
        var sArray = Array<Character>(s)

        // while left pointer is less than right
        while left < right {

            // char at left positon is not a vowel
            // and left is less than right
            // increse left pointer
            while left < right && !vowels.contains(sArray[left]) {
                left += 1
            }
            
            // char at right position is not vowel
            // and left is less than right
            // decrease right pointer
            while left < right && !vowels.contains(sArray[right]) {
                right -= 1
            }

            // if left and right chars are vowels
            // swap them using the pinters of right and left
            sArray.swapAt(left, right)
            //increase left
            left += 1
            //decrease right
            right -= 1
        }
        return String(sArray)
    }
}

// Example usage:
let inputStr1 = "hello"
let outputStr1 = ReverseVowelsSolution().reverseVowels(inputStr1)
print(outputStr1)  // Output: "holle"

let inputStr2 = "leetcode"
let outputStr2 = ReverseVowelsSolution().reverseVowels(inputStr2)
print(outputStr2)  // Output: "leotcede"
