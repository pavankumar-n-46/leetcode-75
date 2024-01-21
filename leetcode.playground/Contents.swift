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


//: # Reverse Words in a String
//: Given an input string s, reverse the order of the words.
//: A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.
//: Return a string of the words in reverse order concatenated by a single space.
//: Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.

class ReverseWordsSolution {

    func reverseWords(_ s: String) -> String {
        // let words = s.split(separator: " ")
        // return words.reversed().joined(separator: " ")
        
        // create an empty array
        var words: [String] = []
        // form currentWord
        var currentWord = ""


        for char in s {
            // if encoundered a space, it indicated the end of the word
            if(char == " ") {
                // if currentWord is formed, which means its not empty
                if(currentWord != "") {
                    // add it to the words array
                    words.append(currentWord)
                    // resent currentword
                    currentWord = ""
                }
            } 
            // if space is not encoundered, then keep forming the current word
            else {
                currentWord.append(char)
            }
        }

        // add the last current word to the words as the loops ends without adding the last current word
        if(currentWord != "") {
            words.append(currentWord)
        }

        // placeholder to form the complete string
        var reversedString = ""
        
        // reverse loop through the words array
        for i in (0 ..< words.count).reversed() {
            // keep appedning the words in reverse order
            reversedString += words[i]
            // if its the last element then don't add the space
            if(i != 0) {
                reversedString += " "
            }
        }
        //retun the element
        return reversedString
    }


    func reverseWordsInOneLine(_ s: String) -> String{
        s.split(separator: " ").reversed().joined(separator: " ")
    }
}

// Example usage:
let inputString = "   Hello  World  "
let outputString = ReverseWordsSolution().reverseWords(inputString)
print(outputString)  // Output: "Hello World"


//: # Increasing Triplet Subsequence
//: ***
//: Given an integer array nums, return true if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k]. If no such indices exists, return false.

class IncreasingTripletSubsequenceSolution {
    func increasingTriplet(_ nums: [Int]) -> Bool {
        guard nums.count >= 3 else { return false }
        var first = Int.max
        var second = Int.max
        for i in nums {
            if i <= first {
                first = i
            } else if i <= second {
                second = i
            } else {
                return true
            }
        }
        return false
    }
}

let nums = [5,4,3,2,1]
let increaseResult = IncreasingTripletSubsequenceSolution().increasingTriplet(nums)


//: # String Compression
//: Given an array of characters chars, compress it using the following algorithm:
//: ***
//: Begin with an empty string s. For each group of consecutive repeating characters in chars:
//: ***
//: If the group's length is 1, append the character to s.
//: Otherwise, append the character followed by the group's length.
//: The compressed string s should not be returned separately, but instead, be stored in the input character array chars. Note that group lengths that are 10 or longer will be split into multiple characters in chars.
//: ***
//: After you are done modifying the input array, return the new length of the array.
//: You must write an algorithm that uses only constant extra space.


class StringCompressionSolution {
    func compress(_ chars: inout [Character]) -> Int {
        var readIndex = 0
        var writeIndex = 0

        while readIndex < chars.count {
            var char = chars[readIndex]
            var count = 0
            while readIndex < chars.count && chars[readIndex] == char {
                readIndex += 1
                count += 1
            }
            chars[writeIndex] = char
            writeIndex += 1
            if count > 1 {
                for digit in String(count) {
                    chars[writeIndex] = digit
                    writeIndex += 1
                }
            }
        }
        return writeIndex
    }
}

var input: [Character] = ["a","b","b","b","b","b","b","b","b","b","b","b","b"]
let newLength = StringCompressionSolution().compress(&input)
print(String(input.prefix(newLength))) // Output: ["a", "2", "b", "2", "c", "3"]



//: # Move Zeroes
//: Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
class MoveZerosSolution {
    func moveZeroes(_ nums: inout [Int]) {
        var nonZeroIndex = 0
        var i = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                if i != nonZeroIndex {
                    nums.swapAt(i, nonZeroIndex)
                }
                nonZeroIndex += 1
            }
        }
    }
}

var inputNonZeroNums = [0,1,0,3,12]
MoveZerosSolution().moveZeroes(&inputNonZeroNums)
print(inputNonZeroNums) //Output: [1,3,12,0,0]


//: # Is Subsequence
//: Given two strings s and t, return true if s is a subsequence of t, or false otherwise.
//: ***
//: A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

class IsSubSequenceSolution {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        var sIndex = s.startIndex
        var tIndex = t.startIndex

        while sIndex < s.endIndex && tIndex < t.endIndex {
            if s[sIndex] == t[tIndex] {
                sIndex = s.index(after: sIndex)
            }
            tIndex = t.index(after: tIndex)
        }
        return sIndex == s.endIndex
    }

    func isSubsequenceByPreProcessingT(_ s: String, _ t: String) -> Bool {

        // Map of t characters with there position (index)
        var charIndexMap = [Character: [String.Index]]()

        for (index, char) in t.enumerated() {
            charIndexMap[char, default: []].append(t.index(t.startIndex, offsetBy: index))
        }

        var currentIndex = t.startIndex
        for char in s {
            guard let indices = charIndexMap[char] else {
                // if no indices is found for the char in s, then substring does not exisit
                return false
            }

            // get the nextIndex is any index from charIndexMap list of the char which is equal or greater than the start index of t. eg: it could be just the first index of the indices.
            if let nextIndex = indices.first(where: { $0 >= currentIndex}) {
                // then we move the currentIndex to compare with nextIndex + 1 in t
                // eg: in t: ahbgdc if fist char was a. then we move the currentIndex to h
                currentIndex = t.index(after: nextIndex)
            } else {
                return false
            }
        }
        return true
    }
}

// Example usage:
let s = "abc"
let t = "ahbgdc"
let subSequenceResult = IsSubSequenceSolution().isSubsequenceByPreProcessingT(s, t)
print(subSequenceResult)  // Output: true


//: # Container With Most Water
//: You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
//: ***
//: Find two lines that together with the x-axis form a container, such that the container contains the most water.
//: ***
//: Return the maximum amount of water a container can store.
//: ***
//: Notice that you may not slant the container.

class MaxAreaSolution {
    func maxArea(_ height: [Int]) -> Int {
        var maxWater = 0
        var left = 0 // starting index of the array
        var right = height.count - 1 // end index of the array
        while left < right {
            var w = right - left // distance between two poles holding water
            var h = min(height[left], height[right]) // takes the min hieght of the two poles to hold water
            var waterArea = w * h
            maxWater = max(waterArea, maxWater)
            
            // if value of left pole is less than right, increase the left pointer
            if height[left] < height[right] {
                left += 1
            } else {
                // if right pole is less than left, decrease the right pointer
                right -= 1
            }
        }
        return maxWater
    }
}

let maxAreaTest = [1,8,6,2,5,4,8,3,7]
let maxAreaResult = MaxAreaSolution().maxArea(maxAreaTest)
print(maxAreaResult)

//: # [1679. Max Number of K-Sum Pairs]( https://leetcode.com/problems/max-number-of-k-sum-pairs/description/?envType=study-plan-v2&envId=leetcode-75)

class MaxOperationSolution {
    func maxOperations(_ nums: [Int], _ k: Int) -> Int {
        var frequenctDict: [Int: Int] = [:]
        var operationCount = 0
        for num in nums {
            let complement = k - num
            if let complementFrequency = frequenctDict[complement], complementFrequency > 0 {
                operationCount += 1
                frequenctDict[complement]! -= 1
            } else {
                frequenctDict[num, default: 0] += 1
            }
        }
        return operationCount
    }
}

let maxpairnums = [3,1,3,4,3]
let maxpairK = 6

let maxPairResult = MaxOperationSolution().maxOperations(nums, maxpairK)
print(maxPairResult) //output: 2


//: # [643. Maximum Average Subarray I](https://leetcode.com/problems/maximum-average-subarray-i/description/?envType=study-plan-v2&envId=leetcode-75)

class FindMaxAverageSolution {
    /*
     1. check if the array size is greater than k
     2. find the sum of first k elements by iterating from 0 to k-1
     3. find max average by dividing sum / k
     4. sliding window
        a. iterate the array from k to array.count - 1
        b. find sum by taking current element and subtracting current - kth element
        c. find the avg of sum
        d. assign max average = max(currentAvg, maxAvg)
     5. return max average
     */
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        if nums.count < k {
            return 0.0
        }
        var sum = nums[0..<k].reduce(0, +)
        var maxSum = sum
        for i in k..<nums.count {
            sum += nums[i] - nums[i - k]
            maxSum = max(sum, maxSum)
        }
        return Double(maxSum) / Double(k)
    }
}

let findMaxAvgNums = [1, 12, -5, -6, 50, 3]
let findMaxAverageResult = FindMaxAverageSolution().findMaxAverage(findMaxAvgNums, 4)
print(findMaxAverageResult)

//: # [Maximum Number of Vowels in a Substring of Given Length](https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length/description/?envType=study-plan-v2&envId=leetcode-75)

class MaxVowelsSolution {
    func maxVowels(_ s: String, _ k: Int) -> Int {
        /*
         Solution:
         1. map the input sting into array of int by check if each charater is vowel and assigning 1 or 0
         2. calculate inital count by taking the first k elements of the array and summing them up
         3. if the input s.count is <= k then return count
         4. create an maxCount and assign count to it

         5. in a loop starting from k to array.count - 1
            // sliding window logic
            a. calculate the count by subtracting count with array[i - k] and adding array[i]
            b. assing maxCount by max of count and maxCount
         6. return maxCount
         */

        let array = s.map{ Set("aeiou").contains($0) ? 1 : 0 }
        var count = array.prefix(k).reduce(0, +)
        if array.count <= k {
            return count
        }
        var maxCount = count

        for i in k..<array.count {
            count = count - array[i - k] + array[i]
            maxCount = max(maxCount, count)
        }

        return maxCount
    }
}

// Example usage:
let MaxVowelsSolutionInputString = "jwzrlilhzmrqylnamfsnloxyyznoxwdfqurynyfhhojqufxbxbccxenqxfmuyyhrjtrzdilavcbcqhwqmwokowagrrchlvhydqamlqdkpobttmvsoqmhvfcalifiiwsdwpnrqkwpaflmjdoihyufzzikjmxsxuenpvoindyhahilrlrxemlnvzucnozwoekdyngtioqrtivvfkwqvmearwuonzblhoocqobvbgxasqvtlkllypkcbnnsktzetiavhnsqiewtymzniwdnfkivggbnzseuittqyxtwikjnjzytbgrjdwxxvvjwlcwzrntcjrmvsdmfkcusthtfqqaxumtmfomwnkqorwamkkidfcdnxxwmymclykuecxgfwighnefypvfhidysysiwhrgnnquwzkgrcbrczypnziebbktnxojywqbovrrhtqmigoozlhmmvbbuflzzkybvdjmbsasdbmmytcycdfvxwiklimkaueholijewtshtgyncaocaoqzwcqxjhicsgwdduaxvpiggwtmcpxhjhaqeeoaamqzkgiimcfcawlbovjdacabxbxlvsnabpnkkwldbxkbbcnfgwlbgxjbbkjpbodgstaxwsxqgpnjlmrabchbsopglhisskvyyjpujashhubeuqlnqowmkfemddtnqbcktjhzvothzwihqamxddewnudsrjfxsdmvhacirpagnzgexhiktpabronxgujipoquveduqdtivectmltzbafqbtisbnzqgomrkgscohwhehiucvkalylftqhqllwlaxrmpsymifyhbfhdenkvwbsldnczvnlbknesjfrphcnzmoeiluynkrsswnyznfkahxytyhbcqlckcdxwxmbyddyumdylizeampeafizbqulajrygttfqsqmlrpuippbeldocqonkceagidbykencnotxykxhmxwvjkzrqpkhqpgojxikvvirlstthczopwdiorkyutmslnxbotnoxszqlhbbfywazrdokyasurjwhruzuavdxhmojpqfcyttqotopwsycpweyqsqxojcaymjrlatojdcbvhzdptakylgbfxvukryolmwlbaocnrgaooewfvimnaszjswofcicgqwtapvtjjiuyqpyupkfywtssbahmxonadgqncjqtyvkbomdklxybbqwhrasrtnmbpfxnivcwgfuvmhirnzfuladhwazngiwcdaaaycrrufmloegodfxieppqyesiebwtzquwmxkligoklprwrvdezpplzyndzdwdihsbhlbhegjpkbcxrucmutlsbruchtcntdwanzkykzksjawqmzuldiazvpckgfjzkekprrqzapnsmxzvosxnqujkomqimgjudcxyxiqmzkslfskrffhvwwyrdbzuttxkvpvdmfrcyrdxgyezlqnipmbzgbpyaczwknrzjjfetnuzzakwyfsndggyyzubzojtgqbnmkgomckycynjltvjanedurwsphuduvuicgsftuzusegzxplguyyagzzrxsvulqshikjvptdwhobqhjxzdgcsotcsswzutyruwodmnawthrxtzqmimkqsgglofnriqamjfrpjjzshdjvwqghougsoaoteuifuibrtxahscaxfyzwcnpcelrbjxgtkdddmdrafzctqgmcomplavyxvehzipgskaraisclfuybdfkgflbponbmrbrwiibcylgsmrmwuktyxfswqcrbyqswidlgmygrpngobgajwyppgicgebizlkyctpqgooaxwquipkvjjqkqvustyeigyxwrvmflarqrsrttyuvxokysiwoiqnfxlcavruzdwwbcvklxorttrozggagzjvigybscjbrvwhkpracziuydycsmpvppvulwjzgqdpnctbemietmgsbckkjqjlsdbvzeupguqxuklommbrjbjuofkujyiwidctrpsrouswzurxixaxfbhhcqnvxadhdahwpbpydilugliumdxibslrqjmaiykwlhzmrykrxrkwtmqjplqxhrqcnifnekyjepcnhotojrjhyldbmhejyoxveqcvnchwxbxlqjofrdvwyhjxosixrtfdzhwxaaplekbrpscqryisuhrlujzcuujnmceeurbxkkwpgsvbwhyigutzeqadhokxpvxhykokvepggwklmpoymsltsfytbylbrzuzpcfxtntdlnxzjpbqkihwsotvxplklvwddgcqjzxxgcsktkznecdqlkbhrgmtjxkwtlfoxycafhooypxmomqljkrzrmzjwizvxnucoyywthwxxigsyucngecwlwpwxasqwfmyqfwfmetuamcjzzogqizmjbvsfwlltrvjfmbdntaanqduwnghaupdmlcqwunnrpufjamxcxinolkrntbcfpclvqctzjifvesjcffyapocptqiifvtblqphzrssaldzrmaouhhuquiknrvbttkqhwcfebvttnxvyimyfbwlxmwntwlbmlspkyglqrfpvrkrvxmdnynlnyzeilahbxrzskcqmmagvepviogthmwxgthbneatmjkyrcyouacomfbxlbbckfkrgqaefwwhetucdbyxwphlcxwzokepfytgrhzyiciushrxfohekgdhnxwitwjxiklxsxqfaairucjajwtgdrgqwmxceogeelcmvsuhndjggsljcvcyrbvxcdxsszciefykonnkjokkdggyksommmxjhartrfvfghfihzsjivpujveqbtxjzavwnznfyggujqavnwgxkaovmqdnjeqqlcvjzptuecssulzghhqmfndyghqcikxwlmewhuqpmroswdgayzuqstjgwfypuoqsqnxeyftsghwmdwkutdqkiaxlrrveckcspbbgdyccqocwnyvmvysewnybutfguctlvucekadpdmpsjhxqaytzokegrbtyxvwksedjnokkqwhfvszjoalksmxavrdrewmxnactajirxfxvambpeuxfusvfzhfrkiefpuyyhggknjgfuhyjpzfpccvzvuimitpsliwxglceomadzsgtpuiulxtzdodrgmavupxksuffdqpnwiqynvdzntdrqdeutbriwrewjxhcjdqerbresnxalyftbegjokjutltodtsfokakmcxvcmmjitcmhvhuxboveaqdomuahqwfnlrsqobhoscgznndvmcrptgtlgpqlcgctfmmmpszdjbwrxdmgkajiwhzxroeqddfpwtodgzezoaqtakfjhnbokchyuwnaozetyjlgnyddulzuavicbhfkdvlckkeadvepiyetbmqdngasgivotwwgowvhazejrgouakfuqjwpscnzxrosjwcqdsiawvshouomqvencrzenzjutpvffiocdubpqbbabppndfrizxbphsnqgyzyebcapomkvwxoceibcteimydxgmeruhoohscddippyhhhefwyfwgiqohowibemattbwpeefkjjlwnszvswiuenjnlgmsvkcnmfkanlhkdfmrvtcvqaztackqaekdqdfifskvgatvkabokvrfyshhpnmyvatnlnhsuovyfrdnopovvihgeltaalirnjqtrowkuxvxykwzeheabqbmcifpbmiwsfpelanwtjwsnaqoezcqdrzegulkcwggkgddbejysiwpmxzvjdchlzuezgfudqzlinljunphiccplziogcevkpuvirdspzfgitaeczmracxiwqkvtlndkeyrgyfqodyhjrnprmzjfarkbicqclpzyklkazppptuauwsygsmlrsykkrgoaexolmmerjxslgfuawxlrqaxihwmdwdjgmdpfjcdnshbgesuwymdxliuzfzyfhvbldfwzayxfemxmtdxtlmqpoeqsozwkljdqglgkrnkyoyuivdsrhkvnfyiypwhdwldamtuoyredsesgbgcwsxpcgjkbkmkdwhoykjowdkqgcvyyexpgidpylsbchnpmyajtqunanlefwleheciqcwpyijzmscmxqmzgmlbavbyaioorppqkhrnqmqkfexvnmyqyuaanthvvuppoxjyejvjgheuobicuisojrmmcjrhkljcdoykwppqfgdhugiyveeeipjbebdxexjiwmdmvvnpoyrlznhswqivzfckeavazfyrrwsnrofbahhhmmkfjqnkopfavqitvdgcolxziethjqptvxxukoqeibfaxdyyyqfuwznfyqjcxbmyjcjmxcnqgofpexlgrputobbspqmuazjcmomtotqarzjhzzeeuqlkdkhqwwbfhyyjnajuatwyvsxytlimbthiykdhmiaycyvdhoijapnobjfkcbcfmkmybiwtxkeloygvmimrvjsmqmdanxtaehpcikzfcxxamjkujylrutmmcvsnmnstskwrnqlkulzpydygiqdrzgtgevxhdxznabatdjbwobgiqiejdodkeycavftzbsfldoiuasmrqrhfnvfjinnqaorpgcaomlctvplahgfjnubhjdgpoeptljdzdyddpkzunskjnldfgowppuhpricprbzjwkesylvzizspwghfzoyublviaqadxekgtigyobyyhfbbfjtbnswkueguczuzzfabbtwcixhontfqcomnoszqgpqytkwkzcgncxvsauummkworuuwalemwrcmmyjfqrioumrdgzyupudwgxeguwmpxopvsdohfpbcfemthdzhwtpdapsfkkqfefyfndkvbiubvvuonrockyrnsgfqbyaixbcozqyaavybzdhsfjmtocaovvnxexjljedwkkmmovdutvuwslscxzgkrrovbhrelwqhzebzmlwkqvceoicolnvtchfgudbvlkotbepzcukyhumwhnvjtjopizakncehmxxxjrxpaxjfgsbwstvcqgwwlmspuxqyxjyvihkmxviahnrrnanxkzoukbpwqkbfenuvbppgojxskgianetopnylnbtnpajyddqcyzclmurfrztmksxvpowuvgbbqvokkmrnesyzadeqhhudcylpcshvdvghpaumnywcxkxbcullmoifphrvbapvufavvfnmyhgivmdornkfjxkgshpxscncwepjirrfdznmbxfuvokrhpfcljzqvyltcjpcyxyzwkyapzspraiouqcorobvajyfiaftbnhhtaisxyztetxclrokwjtwyqaalyvhhrnpfddofmarwjrwmiigbqgxboxtykufjefbkeskstwjxgdlryjnvxqxmwxkzgwscsybmolxafwwgfphgevmgxipybrycgpjhabspahiidtnezkkaiwgtbgiootvtwntbojptjgeqmggushbhzxkzxenycjxskyuvhcatiiilfmgotecacqnpjagxrejipxvxgdqbcwbeaxdmnqgjjddxdndyvylqhdddjlrtqqspogifizgsopapyojoaqhfomeacdljzwhpqcsekbsgccxoskxugijjsstapppkyafkxzmfoebqbgvsakcxzvfibdsqhljpvhqethbabeofpasiujyowtvdmcftvjpmhvtuscqycahdlnbnqjxfhzwupzuiaswwwyzlvdbosqicktehwqrmwjcjhvbkkalpoywwuhwzwlncvsycbvluwzedjtagaaumnscksomurmzmsvgbjhykeanhshbvppwssiogvbqwnchyvftqkcxpeaswieygyxwhjywrfewepardplrhqbqwunimgieeyfunfasdvykrrsgvceddhckeeenmxtijfqfottvqjbvofunqodartyvujlhqeazbztrdsaeokkauzutiehxnsldjogkfqrogabnkzzikkozmwshrvibobcodlgfglydbserpzomoxvdmoscgfvdwjzkfxzggprukivuaqfvekfvlgibxggunqeixacaorzbidsrjagddmxbxnweujamaezuztqziudypnhfueyjipnrpbxitmfzugymyolfyeoqhjbtvhtsjmvyrylujuhuxgqrfglaaffepjjqqsilutzmgombaqpxgnmwaljtmfhfoljfjqgioqmzshdjyxrfcmlnyrhbpqtccciysnjqychunqtubeyfclvohlklokceunprugkrhgrtxjczhlrcbuamloatmypvdhjyppueibsfzyalnxtgbbjauhwiwicqaayxohxriimhtvqykvdnqktukirjlsqlrqyrtfgxbtitnceuykwqlxpowprhswqelkknrqinrvfjwrfdiqbzsqhmzbytulgnpqqgxnhcdzijivpxioyigxyjdynriucdocplfrqtbvbmtoaqvxezkhsugsalmkscdhgwshqfrxnshbokfzyrrazvcmlfnklolsdzpdmudghcpudvqzxvcmlagwxzybbwfnmjzlmzbyxgwhipqllfwrayqivjrmbtwihxvsydujgbvlkbxhkdpqpkywtiodcuseeyrpxnpynvihhxmcrflznovbzoakdemyuhvzjlishcfxgqhuvunluflrzrpkjdjvsjlzpctlqgshricceewbilcldewmrdzaocgsigcafrrwcdwoxaceqgiojfbglbhxdfgbsmibbtxmgvqpbcjjtmqkdfokpqvopjbmlzaypjzrbgbgtiryxtkuruuvtganatsytgmrnztqmznqpnghaoaoqrjvfzgmpdnvsiwizsgfgpaxnziwzcgmfhdelfhknfmeugyejavmctyympnpkhnalmdcvjerdgevdgbuphfgbmazwhqzsordvcaokybwkonguunrvugfimvzrfawggejsehisetmidykocdqgdagxedhoriowjikfyqjlkvysmvpnjqjjvggvchnnlltqpbuixhhlewglpuqirbxrcqxjmmfjddixrwtpqpunvzqbjzbqgvexpwjzrdbvgxgqjpmwrygelolyfnbsltkdyhtxywsnpirecwxdtpdzspvzktxallfhwxfdbnrugovhluoqwneofkivjcigngsxcmulmxebhjmkllubsdswrykrdpzmoznilaxjujzsreqvtmejnnyioqiimxgqynrtwckinybqhuvojwxptabsobbxuwwkvopxrqllounzhsmouefgodeqdescqiakrufversotxmuasbstwwxuqvoxdyfqqtnmybvauxfhaonitbqjzsfgyhvqgvvwryrxwlxhpqyayutabcnhobuoyqfajabgpulgdcwqryfcmpjgzlvztgsrkrckbcrtqsfgvkqxgeaklcpnaqhpqptyduzxrgpdfzttzpbxbzxvexhjczmfbrdoaahqhguhrhblxqcsttjxozubdfngfqkqcmaetlwjklrivlelqawxzzmgywwzmfpppwbgkqmbysflcmyxkecstwwulrelqlvctdcarbrivydckvkdygggvaexskkgtnnsrtrcqxccqzdzoewqsifoflcvubtivjjwzcjjaxbcowdlssfjaceleopjvldxezaewktvghpzrizedgalemmwfxicuqienvugufgtxmgtmtopjslvfnhimxuuyihmrebvrsmqpdgwnmutcorsfbfoihtbycsnnmjcabmhwcgrzhtxmwyqokzwanzneqjolghmgvyyjpxxueovynyuikrpkkzyzvtqvwhfyonuuhbxwweqjnurkxylpvamlfknlazqpeieaewlylgpqkprpbkxioesvxgcbkbkknpszrvhxdogtyxgphzrdinfpnrktciqocpxwmownqmsakcaqoiozyjiqwskqvdblcdlmnadtrbycwdjbvaxzjaabvpvppjmnxzznujokwaqwdhjyivrxypkpfejyskwxqfexyvgmbwaynrrwkvghluirdncpeqgfkwbfrmruqnirlckfhrjxwtaqadmqgbisqqtnsvhupwxrfpjmtkwebgmsoxbbfhlejvhumfbootjlzoowrdlspvwzrnpmjmnlafhfylwhhudewzjtcnxxemjuhzwnzybrwgxeairkytnhiwnqlebolcftbsbqhndhevvsiwewtxdstmhilwutrnxilwyqcsktmglicojzohgsdyelvvmpcwstuoguevcuswipfdlgpxvrqwindhuxqckzjrxvauxzbxdeujjzvzgujagiuxgkzyhxwpxqplkempigipbtiwwtpcvmcomtarkdzoguraqehgzgvuxdpbqdidroedmyclllegicnxlyjxwmfdtoyiprjswyrgxfpkmcriapprtcglpkbfmfiiqezfjitrskqvuureqgfevuvhtwuhdbroaexkjqpwkgyjlojjgucbckwgtquuetnqbyqjvjiulocflylutyoamkrrmxexlhfvvjqiiaalpggxjwxxodjedihidqwzpwcyycjylbkyosqkvtxsbvljiwynjjtwyllryybzubcfqyxrusviqbvbdjmusuoggazvwgdcidaeylgudyjnunmxqoziimljlkildihekdzubfvopoypgvfkxpfwhakgjfnwlqmqpmoxwpjyqkdrdoifhlxgnyuvrpydhlgnjznbckyxdnzllqiwisivuvqvzkyeuvusqctcbchladsxitjjsafraiinltujusbtxwjqrfqiroqssqkwilmgfrlwxfpzexcflnaevwyoarfivhkuimngphdighgqekerxbrttcmmhmernqycokntmvgvzmrvpajsmjnfxqdtpvtzaezhmowuivbyfggvydzoavvphrbpuknaizcvtrccgkvwjxqmwyrgcjxvynhjrlskctvgfqwxztnpmbwpmghwxuajbcxnwqvojfqvzzqkvjbzwhyknfasurxhjzfwnkhufvnndabzmxwuimtalzdshoxrzcnblzmkdanuxksdqafkprrbniifzeeipyqxppjtsneqbleuyhvnjljkvidxynmydcveopysfdtalenxdjojdtapxndobrjhfxwuwqdmoulzjpbgqllqhjuiriwyswokjjviucuxkuluobtmmsqqyxxuewmwrdbgwrdckxmjsqywnuwlbrsjdrgczkgcmbfmibgdbicmhzpvufbcneyhmjjdbdnnujausticecxihzsabzbffveyfewzzhbuokolvvxweuhvdnmvylolxyxzvhvsirnuienakmrjslokyaklbgrxlzgjjrfqjjynecwwdjczpvoqpudmyuifgpukcwvheqmmkxnjikhgxumlbqrzvqovtxbwkpyltgzuxiocxwpqdnqultjilswovpnmvsidfdyzgihjyioxrsadnbmaaxdfnggxrggmqhibocjlhkixiseiwkxizscawhtqwsaiyaswbiqitcgpvrtaijkszekzklirdxyxfmzraddlnromcdqdvnjzroqarfekwjvqahadidvuhdixswivifnrnrtjvhonssrxkskppzowhipwfjczlyvzrpqtdwfjabsmuaaonmycliqmxawtwuqpjxlwnjckobrvzehsimxakawqmbccdtckbqmezuzweposemwhkwvecvkgisclzgxxammgznzbbhjaofqxesaifylpkpvsskunzwzpmqymsexclragbjubtlyzivovnhwakndvoayrxyyjobdmgdqdpslcwfdjzyqzieuugrfelipbkcjqjbfsifxiqgrjobqofmcmoqjzpvorvhdrkhabideqmizjpqmwnccvqssrenwqtcshurnmlidmcjlytzchrsgqfuqiwqbvdhwlmglxpwikodlwazpowzsqmwcvfeqjxcsqyfxhmlxwxcmmediioftdmxovsjqinidfqazzsbicnrzhebwlspecpaoedebng"
let MaxVowelsSolutionSubstringLength = 100
let MaxVowelsSolutionResult = MaxVowelsSolution()
    .maxVowels(MaxVowelsSolutionInputString, MaxVowelsSolutionSubstringLength)
print(MaxVowelsSolutionResult) // Output: 3
