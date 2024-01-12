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


